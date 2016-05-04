require_relative "envGen/add_file.rb"
require_relative "envGen/add_gem.rb"
require_relative "envGen/init.rb"

class EnvGen
  @@options = ["init", "file", "dir", "gem", "help"] # all possible commands

  def self.file
    ARGV.delete_at(0) # gets rid of "file" to isolate files to add
    AddFile.multiple(ARGV) # adds files individually
  end

  def self.dir
    ARGV.delete_at(0) # gets rid of "dir" to isolate dir to add
    AddFile.dir(ARGV.first) # adds Ruby files in specified directory
  end

  def self.newGem
    ARGV.delete_at(0) # gets rid of "gem" to isolate gems to add
    if ARGV[0] == "-s" # kicks off search
      new_gem = AddGem.new(ARGV[1])
      new_gem.gemSearch # searches for gem specified
    else
      ARGV.each do |arg|
        new_gem = AddGem.new(arg) # creates objects for each gem
        new_gem.gemEntry
      end
    end
  end

  def self.parse(input) # handles user input from executable, ARGV[0]
    if !@@options.include?(input)
      puts "invalid command"
    else
      case input
      when "init"
        Init.init # handles environment creation
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
