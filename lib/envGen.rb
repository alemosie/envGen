# require "envGen/version"
require "pry"
require 'io/console'

class EnvGen

  attr_accessor :config, :env

  # @@gemlist =  `gem list --remote`.split("\n")
  # binding.pry
  @@files = []
  # @@filePath = File.expand_path $0

end

obj = EnvGen.new
# EnvGen.file("/Users/asiega/Development/immersive/personal-projects/envGen/lib/envGen.rb")
# File.expand_path $0 -- computes the absolute path dynamically
EnvGen.environment
