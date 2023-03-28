# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :osx, '10.13'
use_frameworks!
#use_modular_headers!


#target 'MacTemplet' do
#  # Comment the next line if you don't want to use dynamic frameworks
#
#  # Pods for MacTemplet
#  pod 'AFNetworking'
#  pod 'Masonry'
#  pod 'YYModel’
#
#end

def common_pods
  pod 'AFNetworking'
  pod 'Masonry'
  pod 'SnapKit'
  pod 'SnapKitExtend'
  
  pod 'RxBlocking'
  pod 'RxCocoa'
  pod 'RxSwift'
      
  pod 'YYModel'
  pod 'HandyJSON'
#  pod 'CocoaExpand'
  pod 'NNButton'
  pod 'NNLabel'

  pod 'SwiftExpand'
  pod 'Then'

#  pod 'FlatButton'
  pod 'Highlightr'

end

target 'MacTemplet' do
    common_pods
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.5';
      config.build_settings['CODE_SIGNING_ALLOWED'] = false;
#      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.15';
    end
  end
end
