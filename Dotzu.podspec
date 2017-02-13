Pod::Spec.new do |s|
  s.name = 'Dotzu'
  s.version = '0.9'
  s.license = 'MIT'
  s.summary = 'iOS debugger tool for iOS developer. Display logs, network request, device informations, crash logs while using the app.'
  s.homepage = 'https://github.com/remirobert/Dotzu'
  s.social_media_url = 'https://twitter.com/remi936'
  s.authors = { 'Rémi ROBERT' => 'remirobert33530@gmail.com' }
  s.source = { :git => 'https://github.com/remirobert/Dotzu.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source_files = 'Dotzu/*.swift'
  s.resources = ["Dotzu/*.storyboard", 'Dotzu/*.xcassets', 'Dotzu/*.xib']
  s.requires_arc = true
end
