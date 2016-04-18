# GEM DEPENDENCIES (require [gem] or $: <<  '.')


# GEM SHORTCUT - when combined with bundler, no need to add gems
$: << '.'


# AUTO INSTALL GEMS VIA BUNDLER
require 'bundler'
Bundler.require


# FILE DEPENDENCIES (require_relative [file])
require_relative '../lib/addFiles.rb'
require_relative '../lib/addGems.rb'
require_relative '../lib/envGen/version.rb'
require_relative '../lib/envGen.rb'
require_relative '../lib/init.rb'
require_relative '../lib/test.rb'
require_relative '../lib/test1.rb'
require_relative '.'
