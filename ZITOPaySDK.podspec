#
# Be sure to run `pod lib lint ZITOPaySDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZITOPaySDK'
  s.version          = '0.1.1'
  s.summary          = 'ZITOPaySDK is pay SDK for users and paying is easy'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: ZITOPaySDK is a pay SDK ,for users it use easy and good idea ....
                       DESC

  s.homepage         = 'https://github.com/bruce-lidd/ZITOPaySDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lidongdong' => '964991296@qq.com' }
  s.source           = { :git => 'https://github.com/bruce-lidd/ZITOPaySDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZITOPaySDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZITOPaySDK' => ['ZITOPaySDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
