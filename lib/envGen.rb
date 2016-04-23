# require "envGen/version"
require 'io/console'

class EnvGen

  attr_accessor

  # @@gemlist =  `gem list --remote`.split("\n")
  # binding.pry
  @@files = []
  # @@filePath = File.expand_path $0

end

obj = EnvGen.new
# EnvGen.file("/Users/asiega/Development/immersive/personal-projects/envGen/lib/envGen.rb")
# File.expand_path $0 -- computes the absolute path dynamically
EnvGen.environment

it 'has a version number' do
  expect(EnvGen::VERSION).not_to be nil
end

it 'does something useful' do
  expect(false).to eq(true)
end
