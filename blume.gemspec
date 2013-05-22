# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'blume'
  spec.version       = '0.0.4'
  spec.authors       = ['Dan Breczinski']
  spec.email         = ['pt2323@gmail.com']
  spec.description   = 'Blume allows you to generate a static website from certain Sinatra projects.'
  spec.summary       = 'Blume is a static/dynamic site generator.'
  spec.homepage      = 'https://github.com/danpaul/blume'
  spec.license       = 'MIT'

  spec.files         =  ['lib/blume.rb', 'lib/blume/blume.rb', 'lib/blume/pilgrim.rb']

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'mongo', '~> 1.8.4'
  spec.add_dependency 'nokogiri', '~> 1.5.9'
  spec.add_dependency 'RedCloth'
end
