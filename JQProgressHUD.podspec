Pod::Spec.new do |s|
  s.name = 'JQProgressHUD'
  s.version = '2.7'
  s.license = 'Apache License 2.0'
  s.summary = 'HUD in Swift'
  s.homepage = 'https://github.com/JQHee/JQProgressHUD'
  s.authors = { 'JQHee' => '122011059@qq.com' }
  s.source = { :git => 'https://github.com/JQHee/JQProgressHUD.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  # s.osx.deployment_target = '10.12.5'

  s.frameworks            = "UIKit", "Foundation"
  s.source_files = 'Source/**/*.swift'
  s.swift_version = "5.0"

end
