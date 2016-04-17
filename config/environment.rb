# GEM DEPENDENCIES (require [gem] or $: <<  '.')


# GEM SHORTCUT - when combined with bundler, no need to add gems
$: << '.'


# AUTO INSTALL GEMS VIA BUNDLER
require 'bundler'
Bundler.require


# FILE DEPENDENCIES (require_relative [file])
require_relative '../lib/test1.rb'
require_relative '../lib/test1.txt'
