# require "envGen/version"
require "pry"

class EnvGen

  @@files = []

  def self.print_usage
    puts "\nUSAGE:\n  envGen [option]"
  end

  def self.help
    print_usage
    puts "\nOPTIONS:"
    puts "  init          : Initialize environment.rb file"
    puts "  dir           : Add all .rb files in current directory to environment"
    puts "  file [file]   : Add file to environment "
    puts "  gem [gem]     : Add gem to environment using exact name"
    puts "  gem -v [gem]  : Add gem with version to environment using exact name"
    puts "  gem -s [gem]  : Search partial gem name and add gem to environment"
    puts "  help          : Display this message \n"
  end

  # how should you handle versions?
  # http://guides.rubygems.org/rubygems-org-api/

  def self.gem(gem) # add gem if value is exact match
    gems = File.new("../data/gemlist.txt", "r")
    gemFound = ""

    while (line = gems.gets)
      if line.split(" ").first == gem
        puts "Adding '#{gem}'" # how should you handle versions?
        gemFound = gem
      end
    end
    gems.close

    if gemFound == ""
      puts "No exact match for '#{gem}' found"
      puts "Search for partial gem name with 'gem -s [gem]'"
    end
  end

  def self.gemSearch(gem)
    gems = File.new("../data/gemlist.txt", "r")
    gemsFound = []

    while (line = gems.gets)
      if line.include?(gem)
        gemsFound << line.split(" ")[0]
      end
    end

    gems.close

    if gemsFound == []
      puts "No exact match for '#{gem}' found"
    else
      puts "Found #{gemsFound.count} gems:"
      gemsFound.each {|gem| puts gem}
    end
  end

  def self.isRuby?(fileName)
    File.extname(fileName) == ".rb"
  end

  #File.directory?
  #File.absolute_path(relative_path)

  def self.file(file) # adds single file, where file is full path + filename
    fileName = File.basename(file)
    if File.file?(file)
      if self.isRuby?(file)
        @@files << file
        puts "Added '#{fileName}'"
      else
        puts "'#{fileName}' is not a Ruby (.rb) file. Continue? (Y/N)"
        answer = gets.chomp.strip
        if answer == "Y"
          @@files << file
          puts "Added '#{fileName}'"
        end
      end
    else
      puts "No file found at '#{file}'"
    end
  end

  # figure out how to go from file name to file name + full path
  # Dir.pwd + "/" + fileName is janky, because it only works within the current directory

  # def self.addRuby(fileName)
  #   if self.isRuby?
  #     @@files << Dir.pwd + "/" + fileName
  #   end
  # end

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

obj = EnvGen.new
EnvGen.gemSearch('rest-client')
