Pod::Spec.new do |s|
  s.name = 'JQProgressHUD'
  s.version = '1.5.2'
  s.license = 'Apache License 2.0'
  s.summary = 'HUD in Swift'
  s.homepage = 'https://github.com/JQHee/JQProgressHUD'
  s.authors = { 'JQHee' => '122011059@qq.com' }
  s.source = { :git => 'https://github.com/JQHee/JQProgressHUD.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  # s.osx.deployment_target = '10.12.5'

  s.frameworks            = "UIKit", "Foundation"
  s.source_files = 'Source/**/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
