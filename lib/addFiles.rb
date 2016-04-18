require 'pathname'
require 'pry'
require 'find'

class Files

  attr_accessor :file, :fileName

  def initialize(file)
    @file = file
    @fileName = File.basename(file)
  end

  def create # creates a files object if not exists
    if !self.exists?
      new_file = Files.new(file)
    else
      puts "File already added to environment.rb"
    end
  end

  def write # adds relative path of file to environment
    File.open("config/environment.rb", "a") {|env|
      env.puts "require_relative '#{self.relativePath(file)}'"
    }
    puts "Added '#{self.file}'"
  end

  def add # handles writing files
    new_file = self.create
    if new_file && File.file?(new_file.file)
      if new_file.isRuby?
        new_file.write
      else
        new_file.notRuby
      end
    end
  end

  def exists? # looks through environment for fileName
    File.readlines("config/environment.rb").grep(/#{self.fileName}/).size > 0
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
    filePathname = Pathname.new file
    relative = (filePathname.relative_path_from dir).to_s
    results = relative.split("/").uniq.join("/")
  end
end

class AddFiles

  def self.absolutePath(file)
    exists = self.findRuby(Dir.pwd)
    if exists
      if File.absolute_path(file) == file
        file
      else
        File.absolute_path(file)
      end
    else
      "No file found"
    end
  end

  def self.single(file) # add a single file
    fullFile = self.absolutePath(file)
    if fullFile
      new_file = Files.new(fullFile)
      new_file.add
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

AddFiles.dir("config")
