# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

target 'radiostore' do
 
  # Pods for radiostore
  pod 'ConcentricOnboarding', :path => '/Users/adhamkhwaldeh/Data/Projects/RadioControllerIos/radiostoreios/ConcentricOnboarding'


  pod 'Alamofire', '~> 5.6.4'
  pod 'AlamofireNetworkActivityLogger', '~> 3.4'
#  pod 'SDWebImage/WebP'
#  pod 'Kingfisher'
  pod 'Kingfisher', '~> 7.0'
  pod 'GRDB.swift'
#  pod 'lottie-ios'
  pod 'IQKeyboardManagerSwift' #iOS8 and later
  pod "SwiftUIRefresh"
  pod 'FRadioPlayer'
  pod 'URLImage'
#  pod 'EqualizerIndicatorView', '~> 2.0'
  
  #Permissions started
#  pod 'Permission/Camera'
#  pod 'Permission/Notifications'
  
  #  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'alamofire5'
  #  pod 'RxSwift', '5.0.0'
  #  pod 'RxCocoa', '5.0.0'
  #  pod 'sqlite3'
  #  pod 'GRDBCipher'
  #  pod 'RxGRDB', '1.0.0-beta.3'
  #  pod 'RxGRDB/SQLCipher'
  #  pod 'RxSwiftExt', '5'
  #  pod 'RxOptional', '4.1.0'
  #  pod 'RxDataSources', '4.0'
  #  pod 'Reachability', '5.1.0'
  #  pod 'ReachabilitySwift'
  # https://github.com/nalexn/EnvironmentOverrides
  
  #  pod 'RxPermission/Camera'
  #  pod 'RxPermission/Notifications'
  #  pod 'RxPermission/AddressBook'
  #  pod 'RxPermission/Bluetooth'
  #  pod 'RxPermission/Camera'
  #  pod 'RxPermission/Contacts'
  #  pod 'RxPermission/Events'
  #  pod 'RxPermission/Location'
  #  pod 'RxPermission/Microphone'
  #  pod 'RxPermission/Motion'
  #  pod 'RxPermission/Notifications'
  #  pod 'RxPermission/Photos'
  #  pod 'RxPermission/Reminders'
  #  pod 'RxPermission/SpeechRecognizer'
  #  pod 'RxPermission/MediaLibrary'
  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
              end
          end
      end
  end
  
end
