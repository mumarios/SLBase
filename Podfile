# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'Esaad' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Esaad
  
  #    pod 'SwiftyJSON', '3.1.3'
  #    pod 'IQKeyboardManagerSwift', '6.1.1'
  #    pod 'DropDown', '2.3.2'
  #    pod 'NVActivityIndicatorView', '4.3.0'
  #    pod 'AlamofireImage', '3.2.0'
  pod 'Fabric', '1.8.0'
  pod 'Crashlytics', '3.11'
  pod 'GoogleMaps', '2.7.0'
  pod 'RMMapper', '1.1.5'
  #    pod 'MOLH', '0.2'
  pod 'LGSideMenuController', '2.1.1'
  pod 'EZAlertController', '3.2'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Cosmos', '17.0'
  pod 'Kingfisher', '4.10'
  #    pod 'RangeSeekSlider', '1.7.0'
  #    pod 'DGElasticPullToRefresh', '1.1'
  #    pod 'SkyFloatingLabelTextField', '3.0'
  pod 'SwiftMessages', '5.0'
  pod 'BarcodeScanner', '4.1.3'
  pod 'DatePickerDialog', '2.0'
  pod 'ViewAnimator'
  pod 'TransitionableTab', '~> 0.1.3'
  pod 'Material', '~> 2.0'
  pod 'UPCarouselFlowLayout'
  pod 'ImageSlideshow', '1.7.0'
  pod 'ImageSlideshow/Kingfisher'
  pod 'BouncyLayout'
  pod 'TransitionButton'
  pod 'Toast-Swift', '3.0.1'
  pod 'MaterialComponents'
  pod 'Skeleton'
  
  #    pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'Alamofire', ‘~> 4.8’
  pod 'AlamofireImage', '~> 3.5'
  pod 'DropDown', '2.3.2'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'RangeSeekSlider'
  pod 'IQKeyboardManagerSwift'
  pod 'NVActivityIndicatorView'
  pod 'MOLH'
  pod 'lottie-ios'


  post_install do |installer|
    
    installer.pods_project.targets.each do |target|
      
      if ['RangeSeekSlider','TransitionButton'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.2'
        end
        
      end
    end
  end
  
end
