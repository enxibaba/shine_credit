Pod::Spec.new do |s|
  s.name             = 'AAINetwork'
  s.version          = '1.0.0'
  s.summary          = 'A base network library that many AAI SDKs rely on'
  s.description      = <<-DESC
  A base network library that many AAI SDKs rely on.
                       DESC
  s.homepage     = 'https://www.advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = "advance.ai"
  s.ios.deployment_target = '9.0'

  s.source = { :http => 'https://your-host/AAINetwork-V1.0.0.zip'}
  s.vendored_frameworks = 'AAINetwork.xcframework'  
  s.ios.library = 'c++', 'z'

end
