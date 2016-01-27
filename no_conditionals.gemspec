# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'no_conditionals/version'

Gem::Specification.new do |spec|
  spec.name          = "no_conditionals"
  spec.version       = NoConditionals::VERSION
  spec.authors       = ["Ritchie Paul Buitre"]
  spec.email         = ["ritchie@richorelse.com"]
  spec.summary       = %q{A support library, to aid in eliminating conditionals from application code, for Ruby 2.1 and above.}
  spec.description   = %q{Conditional statements, like if/else, have it's place, under libraries and frameworks, but not in application code. This library implements a collection of techniques to avoid if/else, initially by extending "Truthy" and "Falsey" classes with expressive yet Ruby idiomatic operations. Please look forward for more features to come.}
  spec.homepage      = "https://github.com/RichOrElse/no-conditionals"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.1"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
