# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'depthcharge/version'

Gem::Specification.new do |spec|
  spec.name          = "depthcharge"
  spec.version       = Depthcharge::VERSION
  spec.authors       = ["Aaron Gough"]
  spec.email         = ["aaron@aarongough.com"]

  spec.summary       = %q{A rack middleware layer that logs the full request cycle.}
  spec.description   = %q{A rack middleware layer that logs the full request cycle.}
  spec.homepage      = "https://github.com/aarongough/depthcharge"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sinatra", "~> 1.4.8"
  spec.add_development_dependency "rails", "~> 4.2"
end
