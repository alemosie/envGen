# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envGen/version'

Gem::Specification.new do |spec|
  spec.name          = "envGen"
  spec.version       = EnvGen::VERSION
  spec.authors       = ["Alex Siega"]
  spec.email         = ["alexandra.siega@flatironschool.com"]

  spec.summary       = "Generates simple config/environment files for file and gem dependency handling"
  spec.homepage      = "https://github.com/alemosie/envGen"
  spec.license       = "MIT"

  spec.files         = ["lib/envGen/add_file.rb", "lib/envGen/add_gem.rb", "lib/envGen/init.rb", "lib/envGen.rb"]
  spec.bindir        = "bin"
  spec.executables   << 'envGen'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

end
