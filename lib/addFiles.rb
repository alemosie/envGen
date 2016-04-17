require 'pathname'
require 'pry'

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

  def exists? # looks through environment for fileName
    File.readlines("config/environment.rb").grep(/#{self.fileName}/).size > 0
  end

  def isRuby?
    File.extname(fileName) == ".rb"
  end

  def notRuby # handle non-Ruby files
    puts "'#{fileName}' is not a Ruby (.rb) file. Continue? (Y/N)"
    answer = gets.chomp.strip
    if answer == "Y"
      write
    end
  end

  def write # add relative path of file to environment
    File.open("config/environment.rb", "a") {|env|
      env.puts "require_relative '#{self.relativePath(file)}'"
    }
    puts "Added '#{self.file}'"
  end

  def add
    new_file = self.create
    if new_file && File.file?(new_file.file)
      if new_file.isRuby?
        new_file.write
      else
        new_file.notRuby
      end
    end
  end

  def relativePath(file)
    dir = Pathname.new "/Users/asiega/Development/immersive/personal-projects/envGen/config/environment.rb"
    filePathname = Pathname.new file
    relative = (filePathname.relative_path_from dir).to_s
    results = relative.split("/").uniq.join("/")
    # binding.pry
  end
end

class AddFiles

  def self.absolutePath(file)
    if File.file?(file)
      if File.absolute_path(file) == file
        file
      else
        File.absolute_path(file)
      end
    end
  end

  def self.single(file)
    fullFile = self.absolutePath(file)
    new_file = Files.new(fullFile)
    new_file.add
  end

  def self.dir

    Dir.entries(".").select do |file|
      # binding.pry
      if file[0] != "."
        findRuby(file)
      # elsif findDirectory(Dir.pwd)
      #   self.dir
      #   @@files
      end
    end
    @@files
  end
end

puts AddFiles.single("lib/test1.txt")
