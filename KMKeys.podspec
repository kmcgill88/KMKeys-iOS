#
# Be sure to run `pod lib lint KMKeys.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'KMKeys'
  s.version          = '0.2.0'
  s.summary          = 'KMKeys provides a drop-in floating text field and toolbar.'

  s.description      = <<-DESC
KMKeys provides a drop-in floating text field and toolbar. A default configuration is provided with the ability to customize to your hearts content.
                       DESC

  s.homepage         = 'https://github.com/kmcgill88/KMKeys-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kevin McGill' => 'kevin@mcgilldevtech.com' }
  s.source           = { :git => 'https://github.com/kmcgill88/KMKeys-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'KMKeys/Classes/**/*'
  s.frameworks = 'UIKit'
end
