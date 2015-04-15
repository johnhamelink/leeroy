# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'leeroy/version'

Gem::Specification.new do |spec|
  spec.name          = "leeroy"
  spec.version       = Leeroy::VERSION
  spec.authors       = ["John Hamelink"]
  spec.email         = ["hello@farmer.io"]
  spec.summary       = %q{Quickly see the status of your jenkins jobs}
  spec.description   = %q{Leeroy lets you quickly check the status of your jenkins builds from the commandline.}
  spec.homepage      = "https://github.com/johnhamelink/leeroy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "paint", "~> 1.0"
  spec.add_dependency "rest-client", "~> 1.8"
  spec.add_dependency "trollop", "~> 2.1"
  spec.add_dependency "terminal-table", "~> 1.4"

  spec.add_development_dependency "gem-release", "~> 0.7"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
