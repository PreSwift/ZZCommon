//
//  AppDelegate.m
//  ZZCommonDemo
//
//  Created by mac on 2023/3/15.
//

#import "AppDelegate.h"
#import <ZZCommon/ZZCommon.h>
#import "ViewController.h"
#import "QMUIConfigurationTemplate.h"

@interface AppDelegate ()

@property(nonatomic, strong) NSString *uuidStr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeDidChangeNotification:) name:QMUIThemeDidChangeNotification object:nil];
    
    // 2. 然后设置主题的生成器
    QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = ^__kindof NSObject * _Nonnull(NSString * _Nonnull identifier) {
        if ([identifier isEqualToString:ZZThemeIdentifierDefault]) return QMUIConfigurationTemplate.new;
        return nil;
    };
    
    // ZZ自定义的全局样式渲染
    [ZZUIHelper renderGlobalAppearances];
    
    // 预加载 QQ 表情，避免第一次使用时卡顿
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ZZUIHelper qmuiEmotions];
    });
    
    // 设置LOG相关
    [QMUIConsole sharedInstance].canShow = YES;
    
    // 配置HOST
    [ZZApiHelper configForBaseHost:@"https://erp.wtjy.com/" baseWebHost:nil cdnHost:nil];
    __weak __typeof(self)weakSelf = self;
    [ZZApiHelper configForDefaultHeader:^NSDictionary<NSString *,NSString *> * _Nullable(NSDictionary<NSString *,NSString *> * _Nullable oldHeader) {
        return [weakSelf handleHeader:oldHeader];
    }];
    [ZZApiHelper configForStatusCodeValidator:^BOOL(YTKRequest * _Nonnull request) {
        return [weakSelf statusCodeValidator:request];
    }];
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = UIColorWhite;
    [self didInitWindow];
    
    return YES;
}

/**
 配置公共Header处理
 */
- (nullable NSDictionary <NSString *, NSString *> *)handleHeader:(NSDictionary <NSString *, NSString *>  * _Nullable)oldHeader {
    NSMutableDictionary *newHeader;
    if (oldHeader == NULL) {
        newHeader = [NSMutableDictionary dictionary];
    } else if (![oldHeader.allKeys containsObject:@"Authorization"]) {
        newHeader = [NSMutableDictionary dictionaryWithDictionary:oldHeader];
    }
    if (newHeader!=NULL) {
        newHeader[@"platform"] = @"2";
        if (_uuidStr == NULL) {
            _uuidStr = [[UUIDStringThen alloc] getDeviceIDInKeychain];
        }
        newHeader[@"deviceId"] = _uuidStr;
        newHeader[@"version"] = [NSBundle mainBundle].currentVersonString;
        return newHeader;
    }
   
    return oldHeader;
}

/**
 配置公共StatusCode处理
 */
- (BOOL)statusCodeValidator:(YTKRequest *)request {
    NSInteger statusCode = [request responseStatusCode];
    NSString *errorMsg = [[request responseJSONObject] valueForKey:@"msg"];
    if ((statusCode == 401 || statusCode == 424)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZZDialogHelper showAlertDialog:@"温馨提示" content:errorMsg ? errorMsg : @"用户凭证已过期，请重新登录!" okBlock:^(__kindof QMUIModalPresentationViewController * _Nonnull dialogViewController) {
                
            }];
        });
    }
    return (statusCode >= 200 && statusCode <= 299);
}


- (void)didInitWindow {
    self.window.rootViewController = [self generateWindowRootViewController];
    [self.window makeKeyAndVisible];
}

- (UIViewController *)generateWindowRootViewController {
    return [[ZZNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
}

- (void)handleThemeDidChangeNotification:(NSNotification *)notification {
    QMUIThemeManager *manager = notification.object;
    if (![manager.name isEqual:QMUIThemeManagerNameDefault]) return;
    
    [[NSUserDefaults standardUserDefaults] setObject:manager.currentThemeIdentifier forKey:ZZSelectedThemeIdentifier];
    
    [ZZThemeManager.currentTheme applyConfigurationTemplate];
    
    // 主题发生变化，在这里更新全局 UI 控件的 appearance
    [ZZUIHelper renderGlobalAppearances];
    
    // 更新表情 icon 的颜色
    [ZZUIHelper updateEmotionImages];
}


@end
