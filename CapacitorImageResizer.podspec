
  Pod::Spec.new do |s|
    s.name = 'CapacitorImageResizer'
    s.version = '0.0.5'
    s.summary = 'Capacitor image resize plugin'
    s.license = 'MIT'
    s.homepage = 'https://github.com/softyde/imageresizer.git'
    s.author = 'Philipp Anné'
    s.source = { :git => 'https://github.com/softyde/imageresizer.git', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
  end