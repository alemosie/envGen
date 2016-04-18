require 'pathname'
require 'pry'
require 'find'

class Files

  attr_accessor :file, :fileName

  def initialize(file)
    @file = file
    @fileName = File.basename(file)
  end

  def self.createIfNotInConfig(file) # creates a files object if not exists
    if !inConfig?(file)
      Files.new(file)
    else
      puts "'#{File.basename(file)}' already added to environment.rb"
    end
  end

  def self.inConfig?(file) # looks through environment for fileName
    File.readlines("config/environment.rb").grep(/#{File.basename(file)}/).size > 0
  end

  def write # adds relative path of file to environment
    File.open("config/environment.rb", "a") {|env|
      env.puts "require_relative '#{self.relativePath(file)}'"
    }
    puts "Added '#{self.fileName}'"
  end

  def isRuby?
    File.extname(fileName) == ".rb"
  end

  def notRuby # handles non-Ruby files
    puts "'#{fileName}' is not a Ruby (.rb) file. Continue? (Y/N)"
    answer = gets.chomp.strip
    if answer == "Y"
      write
    end
  end

  def relativePath(file) # finds file path relative to environment
    dir = Pathname.new File.absolute_path('config/environment.rb')
    filePathname = Pathname.new File.absolute_path(file)
    relative = (filePathname.relative_path_from dir).to_s
    results = relative.split("/").uniq.join("/")
  end
end

class AddFiles

  def self.single(file) # handles writing files
    new_file = Files.createIfNotInConfig(file)
    if new_file # if not nil
      if File.file?(new_file.file) # check if file
        if new_file.isRuby?
          new_file.write
        else
          new_file.notRuby
        end
      else
        "File not found"
      end
    end
  end

  # def self.convert(path)
  #   if path == "."
  #     Dir.pwd
  #   elsif path == ".."
  #     dir = Dir.pwd.split("/")
  #     top = dir.pop
  #     dir.join("/")
  #   end
  # end

  def self.findRuby(dir) # find all of the Ruby files in the current dir/sub dirs
    rubyFiles = []

    Find.find(dir) do |path|
      if File.extname(path) == ".rb" # look for Ruby!
        rubyFiles << path # and compile a list
      end
    end
    rubyFiles
  end

  def self.dir(dir) # takes in dir name, adds all Ruby files in dir
    files = self.findRuby(dir)
    files.each do |file|
      if file.include?(".rb") && File.file?(file)
        self.single(file)
      end
    end
  end
end

# puts AddFiles.absolutePath('test1.rb')

AddFiles.dir("lib")
