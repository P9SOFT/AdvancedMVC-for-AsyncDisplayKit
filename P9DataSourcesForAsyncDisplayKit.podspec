Pod::Spec.new do |spec|
  spec.name         = 'P9DataSourcesForAsyncDisplayKit'
  spec.version      = '0.0.2'
  spec.license      =  { :type => 'MIT' }
  spec.homepage     = 'http://p9soft.com'
  spec.authors      = { 'Simon Kim' => 'contact@p9soft.com' }
  spec.summary      = 'DataSource classes for AsyncDisplayKit from Facebook.'
  spec.source       = { :git => 'https://github.com/P9SOFT/P9DataSources-for-AsyncDisplayKit.git' }

  spec.documentation_url = 'https://github.com/P9SOFT/P9DataSources-for-AsyncDisplayKit/'

  spec.public_header_files = [
      'P9DataSourcesForAsyncDisplayKit/*.h',
  ]

  spec.source_files = [
      'P9DataSourcesForAsyncDisplayKit/**/*.{h,m,mm}'
  ]

  spec.ios.deployment_target = '7.0'
end
