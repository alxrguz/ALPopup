Pod::Spec.new do |spec|
spec.name         = "ALPopup"
spec.version      = "1.0.0"
spec.summary      = "Native card controller like AirPods or Wi-Fi password sharing"

spec.homepage     = "https://github.com/alxrguz/ALPopup"
spec.source       = { :git => "https://github.com/alxrguz/ALPopup.git", :tag => "#{spec.version}" }
spec.license      = { :type => "MIT", :file => "LICENSE" }

spec.author       = { "Alexandr Guzenko" => "alxrguz@icloud.com" }

spec.platform     = :ios
spec.ios.framework = 'UIKit'
spec.swift_version = '5.3'
spec.ios.deployment_target = "11.0"

spec.source_files  = "Sources/ALPopup/**/*.swift"
spec.resource_bundles = {
    'ALPopup' => ['Sources/ALPopup/Resources/*/**']
  }

end