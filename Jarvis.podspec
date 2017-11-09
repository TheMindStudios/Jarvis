Pod::Spec.new do |s|
  s.name             = 'Jarvis'
  s.version          = '0.8.2'
  s.summary          = 'Jarvis'
  s.description      = 'Description'


  s.social_media_url = 'https://twitter.com/TheMindStudios'
  s.homepage         = 'https://github.com/TheMindStudios/Jarvis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Max Mashkov' => 'max@themindstudios.com' }
  s.source           = { :git => 'https://github.com/TheMindStudios/Jarvis.git', :tag => s.version.to_s }
  
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

end