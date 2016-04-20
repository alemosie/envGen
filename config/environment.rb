# ADD CURRENT DIR TO LOAD PATH
$: << '.'


# AUTO INSTALL GEMS VIA BUNDLER
require 'bundler'
Bundler.require


# GEM DEPENDENCIES (require [gem])


# FILE DEPENDENCIES (require [file])


#! ACTION: Dependencies to sort
require_relative '../lib/test1.rb'
