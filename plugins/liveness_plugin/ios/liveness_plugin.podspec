#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint liveness_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'liveness_plugin'
  s.version          = '2.0.2'
  s.summary          = 'Guardian Liveness Detection SDK Flutter plugin.'
  s.description      = <<-DESC
Guardian Liveness Detection SDK Flutter plugin.
                       DESC
  s.homepage         = 'https://advance.ai'
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  s.dependency 'AAILiveness'
  
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  # 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64'
  # 
  # Support M1 
  # 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
