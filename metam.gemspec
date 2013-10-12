# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metam/version'

Gem::Specification.new do |spec|
  spec.name          = "metam"
  spec.version       = Metam::VERSION
  spec.authors       = ["Amine Labidi"]
  spec.email         = ["labidi@mediapeers.com"]
  spec.description   = %q{Dynamic attributes and validators}
  spec.summary       = %q{Dynamic attributes and validators}
  spec.homepage      = "https://github.com/mp-alabidi/mpx-metamodels"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.0"
  spec.add_dependency "activesupport", "~> 4.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "activerecord", "~> 4.0.0"
  spec.add_development_dependency "crack"
  spec.add_development_dependency "sqlite3", "~> 1.3.8"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"
  spec.add_development_dependency "yard", "~> 0.8.7"
end
