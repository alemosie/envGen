require 'pathname' # to generate relative path
require 'find' # to find ruby files within a directory
require 'pry'

class PrepareFile
  attr_accessor :file, :fileName

  def initialize(file)
    @file = file
    @fileName = File.basename(file)
  end

  def self.createIfNotInConfig(file) # creates a files object if not exists
    if !inConfig?(file)
      PrepareFile.new(file)
    else
      puts "'#{File.basename(file)}' already added"
    end
  end

  def self.inConfig?(file) # looks through environment for fileName; doesn't create an object/instance method because it may not be necessary
    File.readlines("config/environment.rb").grep(/#{File.basename(file)}/).count > 0
  end

  def write # adds relative path of file to environment
    File.open("config/environment.rb", "a") {|env|
      env.puts "require_relative '#{relativePath}'"
    }
    puts "Added '#{fileName}'"
  end

  def isRuby?
    File.extname(fileName) == ".rb"
  end

  def notRuby # handles non-Ruby files
    puts "'#{fileName}' is not a Ruby (.rb) file. Continue? (Y/N)"
    answer = gets.chomp.strip
    if answer == "Y"
      write
    else
      puts "'#{fileName}' not added"
    end
  end

  def relativePath # finds file path relative to environment
    dir = Pathname.new (Dir.pwd + '/config/environment.rb')
    filePathname = Pathname.new File.absolute_path(file)
    relative = (filePathname.relative_path_from dir).to_s
    results = relative.split("/").uniq.join("/")
  end
end

class AddFile

  def self.single(input) # handles writing files
    # binding.pry
    new_file = PrepareFile.createIfNotInConfig(input)
    if new_file # if not nil
      # binding.pry
      if File.file?(new_file.file) # check if file with full path of new_file
        if new_file.isRuby?
          new_file.write
        else
          new_file.notRuby
        end
      else
        puts "'#{new_file.fileName}' not found"
      end
    end
  end

  def self.multiple(*input) # handles writing files
    input.flatten.each do |f|
      single(f)
    end
  end

  def self.findRuby(dir) # find all of the Ruby files in the current dir/sub dirs
    rubyFiles = []
    Find.find(dir) do |path|
      if File.extname(path) == ".rb"
        rubyFiles << path # and compile a list
      end
    end
    rubyFiles
  end

  def self.dir(dir) # takes in dir name, adds all Ruby files in dir
    files = self.findRuby(dir)
    # binding.pry
    files.each do |file|
      if file.include?(".rb") && File.file?(file)
        self.single(file)
      end
    end
  end
end
