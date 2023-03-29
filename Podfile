# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

inhibit_all_warnings!

install! 'cocoapods', generate_multiple_pod_projects: true

use_frameworks!

# ruby语法
# target数组 如果有新的target直接加入该数组
targetsArray1 = ['ZZCommon', 'ZZCommonDemo']
# 循环
targetsArray1.each do |t|
  
    target t do
      
      pod 'QMUIKit', '4.6.0'
      pod 'PureLayout'
      pod 'Masonry'
      pod 'MJRefresh'
      pod 'SDWebImage'
      pod 'MJExtension'
      pod 'YTKNetwork'
      pod 'IQKeyboardManager'
      pod 'DateTools'
      pod 'ReactiveObjC'
    end
    
end


post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end
