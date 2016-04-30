# AUTO INSTALL GEMS VIA BUNDLER
require 'bundler'
Bundler.require
      

# GEM DEPENDENCIES (require [gem])
      

# FILE DEPENDENCIES (require [file])
      

#! ACTION: Dependencies to sort
require_relative '../lib/envGen.rb'
require_relative '../spec/add_gem_spec.rb'
require_relative '../lib/envGen/add_file.rb'
require_relative '../lib/envGen/add_gem.rb'
require_relative '../lib/envGen/init.rb'
require_relative '../lib/envGen/version.rb'
gem 'rest-client'
gem 'nokogiri'
