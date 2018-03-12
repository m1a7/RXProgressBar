#
# Be sure to run `pod lib lint RXProgressBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RXProgressBar'
  s.version          = '0.1.0'
  s.summary          = 'RXProgress is an iOS (objective-c) implementation of a Web element known as “Progress Bar Step by Step”.'

    s.description      = 'The library is an account Manager with cells. You can transfer the data models to the RXProgressBar after that, it will do all the work for you.'



  s.homepage         = 'https://github.com/m1a7/RXProgressBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'm1a7' => 'thisismymail03@gmail.com' }
  s.source           = { :git => 'https://github.com/m1a7/RXProgressBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RXProgressBar/Classes/**/*'
  #s.resources    = 'RXProgressBar/Assets/*.xcassets'
  #s.resources             = "Resources/*.xcassets"

  s.resource_bundles = {
       'RXProgressBar' => ['RXProgressBar/Assets/*']
    }

  #s.resource_bundle = { s.name => ['RXProgressBar/Classes/RXProgressBar/*'] }


   #s.public_header_files = 'Pod/Classes/**/*.h'
   s.public_header_files =  'RXProgressBar/Classes/*'

  s.frameworks = 'UIKit' 
  s.dependency 'RXLayoutGallary', '~> 1.1.2'
  s.dependency 'NYTPhotoViewer'

end
