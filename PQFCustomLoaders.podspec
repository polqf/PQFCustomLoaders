Pod::Spec.new do |s|
  s.name         = "PQFCustomLoaders"
  s.version      = "0.0.1"
  s.summary      = "Collection of Custom Loaders."
  s.homepage     = "https://github.com/poolqf/PQFCustomLoaders"
  s.license      = 'MIT'
  s.author       = "Daniel García"
  s.source       = { :git => "https://github.com/poolqf/PQFCustomLoaders.git", :tag => "0.0.1" }
  s.platform     = :ios, '7.0'
  s.source_files = 'PQFCustomLoaders'
  s.frameworks   = 'UIKit'
  s.requires_arc = true
  s.dependency 'UIColor+FlatColors'
end
