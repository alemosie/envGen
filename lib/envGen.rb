require_relative "envGen/add_file.rb"
require_relative "envGen/init.rb"
require_relative "envGen/add_gem.rb"

class EnvGen
  @@options = ["init", "file", "dir", "gem", "help"] # all possible commands

  def self.file
    ARGV.delete_at(0) # gets rid of "file" to isolate files to add
    AddFile.multiple(ARGV) # adds files individually
  end

  def self.dir
    ARGV.delete_at(0) # gets rid of "dir" to isolate files to add
    AddFile.dir(ARGV.first) # adds Ruby files in specified directory
  end

  def self.newGem
    ARGV.delete_at(0) # gets rid of "gem" to isolate gems to add
    if ARGV[0] == "-s" # kicks off search
      new_gem = AddGem.new(ARGV[1])
      new_gem.gemSearch
    else
      ARGV.each do |arg|
        new_gem = AddGem.new(arg) # adds single/multiple gems
        new_gem.gemEntry
      end
    end
  end

  def self.parse # handles user input
    if !@@options.include?(ARGV[0])
      puts "invalid command"
    else
      case ARGV[0]
      when "init"
        Init.init # handle environment creation
      when "file"
        file
      when "dir"
        dir
      when "gem"
        newGem
      when "help"
        Init.help # displays help message
      end
    end
  end
end

EnvGen.parse
