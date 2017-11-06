Pod::Spec.new do |s|
  s.name     = 'Jarvis'
  s.version  = '0.8.2'
  s.license  = 'MIT'
  s.summary  = 'Jarvis'
  s.homepage = 'https://git.themindstudios.com/ios-frameworks/Jarvis'
  s.social_media_url = 'https://twitter.com/TheMindStudios'
  s.authors  = { 'Max Mashkov' => 'max@themindstudios.com' }
  s.source   = { :git => 'git@git.themindstudios.com:ios-frameworks/Jarvis.git', :tag => s.version }
  
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.frameworks = 'Foundation'

  
  s.dependency 'Alamofire', '~> 4.5'
  s.ios.dependency 'AlamofireNetworkActivityIndicator', '~> 2.2'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Jarvis/Classes/*.swift', 'Jarvis/Classes/HTTP/*.swift'
  end

  s.subspec 'MSJSON' do |ss|
    ss.dependency 'Jarvis/Core'
    ss.dependency 'MSJSON', '~> 1'
    ss.source_files = 'Jarvis/Classes/MSJSON/*.swift'
  end

end