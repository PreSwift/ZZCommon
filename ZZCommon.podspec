Pod::Spec.new do |spec|
  spec.name         = "ZZCommon"
  spec.version      = "0.0.7"
  spec.summary      = "基于一批基础三方库整合的通用OC项目脚手架。"
  spec.description  = "本项目以QMUIKit为核心，PureLayout和Masnory两套UI布局框架配合使用，YTKNetwork做网络层支撑，MJExtension做数据解析，ReactiveObjC做信号处理方案，以及其他辅助框架。同时整合了一些常用的代码逻辑，本项目还处于完善阶段。请慎重使用。"
  
  spec.homepage     = "https://github.com/PreSwift/ZZCommon/blob/main/README.md"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Ethan" => "1778031092@qq.com" }
  spec.source       = { :git => "https://github.com/PreSwift/ZZCommon.git", :tag => "#{spec.version}" }
  spec.requires_arc = true
 
  spec.platform     = :ios, "12.0"
  spec.frameworks   = "Foundation", "UIKit"
  spec.source_files = "ZZCommon/**/*.{h,m}"
  spec.libraries    = "sqlite3", "c++"
  non_arc_files = 'ZZCommon/Utils/Class/GTMBase64.{h,m}', 'ZZCommon/Utils/Class/GTMDefines.h'
  spec.exclude_files = non_arc_files
  spec.subspec 'no-arc' do |sp|
    sp.source_files = non_arc_files
    sp.requires_arc = false
  end
  spec.xcconfig = {
    'CLANG_ENABLE_OBJC_WEAK' => 'YES'
  }

  spec.dependency "QMUIKit", "4.6.0"
  spec.dependency "PureLayout"
  spec.dependency "Masonry"
  spec.dependency "MJRefresh"
  spec.dependency "SDWebImage"
  spec.dependency "MJExtension"
  spec.dependency "YTKNetwork"
  spec.dependency "IQKeyboardManager"
  spec.dependency "DateTools"
  spec.dependency "ReactiveObjC"

end
