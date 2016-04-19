# ADD CURRENT DIR TO LOAD PATH
$: << '.'


# AUTO INSTALL GEMS VIA BUNDLER
require 'bundler'
Bundler.require


# DATABASE
DB = SQLite3::Database.new('DATABASE')
DB.results_as_hash = true


# GEM DEPENDENCIES (require [gem])


# FILE DEPENDENCIES (require [file])


#! ACTION: Dependencies to sort
