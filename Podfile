# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'IOSArchitecture'

target 'Presentation' do
  project 'Presentation/Presentation.xcodeproj'
  use_frameworks!

  # Pods for Presentation
  pod 'R.swift'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Alamofire', '~> 5.0'
  pod 'AlamofireImage', '~> 4.0'

  target 'PresentationTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

  target 'PresentationUITests' do
  end

end

target 'Domain' do
  project 'Domain/Domain.xcodeproj'
  use_frameworks!
  
  # Pods for Presentation
  pod 'RxSwift', '~> 5'

  target 'DomainTests' do
    inherit! :search_paths
    pod 'RxSwift', '~> 5'
  end
end

target 'DataSource' do
  project 'DataSource/DataSource.xcodeproj'
  use_frameworks!

  # Pods for Presentation
  pod 'RxSwift', '~> 5'
  pod 'Alamofire', '~> 5'

  target 'DataSourceTests' do
    inherit! :search_paths
    pod 'RxSwift', '~> 5'
  end
end