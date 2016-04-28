require_relative "envGen/add_file_entry.rb"
require_relative "envGen/init.rb"
require_relative "envGen/add_gem.rb"

class EnvGen
  @@options = ["init", "file", "dir", "gem", "help"] # all possible commands

  def self.parse # handles user input
    if !@@options.include?(ARGV[0])
      puts "invalid command"
    else
      case ARGV[0]
      when "init"
        Init.init # handle environment creation
      when "file"
        ARGV.delete_at(0) # gets rid of "file" to isolate files to add
        ARGV.each do |arg|
          AddFileEntry.single(arg) # adds files individually
        end
      when "dir"
        ARGV.delete_at(0) # gets rid of "file" to isolate files to add
        ARGV.each do |arg|
          AddFileEntry.multiple(arg) # adds Ruby files in specified directory
        end
      when "gem"
        ARGV.delete_at(0) # gets rid of "gem" to isolate gems to add
        if ARGV[0] == "-s" # kicks off search
          gem = AddGem.new(ARGV[1])
          gem.gemSearch
        else
          ARGV.each do |arg|
            gem = AddGem.new(arg) # adds single/multiple gems
            gem.gemEntry
          end
        end
      when "help"
        Init.help # displays help message
      end
    end
  end
end

EnvGen.parse
