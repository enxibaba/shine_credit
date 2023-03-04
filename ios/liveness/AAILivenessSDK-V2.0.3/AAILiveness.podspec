Pod::Spec.new do |s|
  s.name             = 'AAILiveness'
  s.version          = '2.0.3'
  s.summary          = 'iOS AAILivenessSDK.'
  s.description      = <<-DESC
  AAILivenessSDK AAILivenessSDK AAILivenessSDK AAILivenessSDK
                       DESC
  s.homepage     = 'https://www.advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = "advance.ai"
  s.ios.deployment_target = '9.0'

  s.source = { :http => 'http://your-host/AAILivenessSDK.zip' }
  s.vendored_frameworks = 'AAILivenessSDK/AAILivenessSDK.xcframework'
  s.resources = "AAILivenessSDK/Resource/*.bundle"
  
  s.ios.source_files = 'AAILivenessSDK/AAILiveness/*.{h,m}'
  s.frameworks = 'AVFoundation', 'CoreMotion', 'CoreGraphics', 'CoreTelephony', 'SystemConfiguration', 'Accelerate', 'Metal', 'MetalKit'
  s.ios.library = 'c++', 'z'
  
  s.dependency 'AAINetwork'
end
