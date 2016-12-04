Pod::Spec.new do |s|
  s.name             = 'SwiftyNotificationCenter'
  s.version          = '0.1.0'
  s.summary          = 'Typesafe wrapper for Notifications'

  s.homepage         = 'https://github.com/Shedward/SwiftyNotificationCenter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vladislav Maltsev' => 'shedwardx@gmail.com' }
  s.source           = { :git => 'https://github.com/Shedward/SwiftyNotificationCenter.git', :tag => s.version.to_s }

  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source_files = 'SwiftyNotificationCenter/Classes/**/*'
  s.pod_target_xcconfig =  {
    'SWIFT_VERSION' => '3.0',
  }
end
