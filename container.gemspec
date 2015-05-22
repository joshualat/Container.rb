# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'container/version'

Gem::Specification.new do |spec|
  spec.name          = 'container'
  spec.version       = Container::VERSION
  spec.authors       = ['Joshua Arvin Lat']
  spec.email         = ['joshua.arvin.lat@gmail.com']
  spec.summary       = %q{Handy Ruby object container for cleaner views}
  spec.description   = %q{Handy Ruby object container for cleaner views}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = ["lib/container.rb", "lib/container/version.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.5"
  spec.add_development_dependency 'rake'
end