# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prpr/code_build/version'

Gem::Specification.new do |spec|
  spec.name          = "prpr-code_build"
  spec.version       = Prpr::CodeBuild::VERSION
  spec.authors       = ["mzp"]
  spec.email         = ["mzpppp@gmail.com"]

  spec.summary       = "Prpr plugin to build via AWS Code build"
  spec.description   = "When someone push to staging/xxx, build it"
  spec.homepage      = "https://github.com/mzp/prpr-code_build"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "prpr"
  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
