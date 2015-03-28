Pod::Spec.new do |spec|
  spec.name         = 'AdvancedMVCForAsyncDisplayKit'
  spec.version      = '0.0.3'
  spec.license      =  { :type => 'MIT' }
  spec.homepage     = 'http://p9soft.com'
  spec.authors      = { 'Simon Kim' => 'contact@p9soft.com' }
  spec.summary      = 'Advanced MVC architecture for AsyncDisplayKit by Facebook.'
  spec.source       = { :git => 'https://github.com/P9SOFT/AdvancedMVC-for-AsyncDisplayKit.git', :tag => '0.0.3' }

  spec.documentation_url = 'https://github.com/P9SOFT/AdvancedMVC-for-AsyncDisplayKit/'

  spec.public_header_files = [
      'AdvancedMVCForAsyncDisplayKit/*.h',
      'vendor/**/*.h',
  ]

  spec.source_files = [
      'AdvancedMVCForAsyncDisplayKit/**/*.{h,m,mm}',
      'vendor/**/*.{h,m,mm}'
  ]

  spec.ios.deployment_target = '7.0'
end
