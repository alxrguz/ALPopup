Pod::Spec.new do |s|

  s.name = 'ALPopup'
  s.version = '1.0.8'
  s.summary = 'Native card controller like AirPods or Wi-Fi password sharing'
  
  s.homepage = 'https://github.com/alxrguz/ALPopup'
  s.source = { :git => 'https://github.com/alxrguz/ALPopup.git', :tag => s.version }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author       = { "Alexandr Guzenko" => "alxrguz@icloud.com" }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '11.0'

  s.platform     = :ios
  s.ios.framework = 'UIKit'
  s.swift_version = '5.1'
  s.ios.deployment_target = "11.0"
  
  s.source_files = 'Sources/ALPopup/**/*.swift'

  s.pod_target_xcconfig = {
    "SWIFT_ACTIVE_COMPILATION_CONDITIONS"  => "ALPOPUP_COCOAPODS"
  }
    
  s.resource_bundles = {
    "ALPopup" => [
        "Sources/ALPopup/Resources/Assets.xcassets",
    ]
  }

end
