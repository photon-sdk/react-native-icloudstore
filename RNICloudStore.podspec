require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name         = "RNICloudStore"
  s.version      = package['version']
  s.summary      = package['description']
  s.homepage     = package['repository']['url']
  s.license      = package['license']
  s.author       = package['author']
  s.platform     = :ios, "7.0"
  s.source       = { :git => s.homepage, :tag => 'v#{s.version}' }

  s.source_files  = "*.{h,m}"
  s.dependency 'React'

end
