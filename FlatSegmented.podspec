#
# Be sure to run `pod lib lint FlatSegmented.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlatSegmented'
  s.version          = '1.0'
  s.summary          = 'Material Design segmented behavoir'

  s.homepage         = 'https://github.com/sameh0/FlatSegments'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sameh-hst' => 'samehsayed0@hotmail.com' }
  s.source           = { :git => 'https://github.com/sameh0/FlatSegments.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/Classes/**/*'
  s.swift_version = '3.0'
end
