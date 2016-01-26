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
  spec.description   = %q{Because conditional statements, such as 'if-then-else', belong to lower levels of abstraction (ie. libraries or frameworks), and not in higher level domains like your application. This gem provides extentions for "Truthy" and "Falsey" classes with expressive yet Ruby idiomatic operations.}
  spec.homepage      = "https://github.com/RichOrElse/no-conditionals"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
