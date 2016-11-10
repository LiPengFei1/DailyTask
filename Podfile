
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'DailTask' do
    
    use_frameworks!
    
    pod 'SnapKit', '~> 3.0.2'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
    
    
end
