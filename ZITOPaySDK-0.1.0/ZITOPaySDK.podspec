Pod::Spec.new do |s|
  s.name = "ZITOPaySDK"
  s.version = "0.1.0"
  s.summary = "ZITOPaySDK is pay SDK for users and paying is easy"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"lidongdong"=>"964991296@qq.com"}
  s.homepage = "https://github.com/bruce-lidd/ZITOPaySDK"
  s.description = "TODO: ZITOPaySDK is a pay SDK ,for users it use easy and good idea ...."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/ZITOPaySDK.framework'
end
