class Init

  attr_accessor :config

  def self.print_usage
    puts "\nUSAGE:\n  enGen [option]"
  end

  def self.help
    print_usage
    puts "\nOPTIONS:"
    puts "  init          : Initialize environment.rb file"
    puts "  file [dir]    : Add all .rb files in directory to environment"
    puts "  file [file]   : Add file to environment, e.g. 'test1.rb' "
    puts "  dir [dir]     : Add Dir[dir/*.rb] bulk file getter to environment"
    puts "  gem [gem]     : Add gem to environment using exact name"
    puts "  gem -s [gem]  : Search partial gem name and add gem to environment"
    puts "  help          : Display this message \n"
  end

  def self.init # if not exist: write config directory and environment file
    puts "INITIALIZING CONFIG/ENVIRONMENT.RB..."
    puts "\nChecking for 'config' directory:"
    self.config
    puts "\nChecking for 'config/environment.rb' file:"
    self.environment
    self.headers
    `atom config/environment.rb`
  end


  private

  def self.config # checks for/creates config directory
    config = Dir.pwd + "/config"
    if Dir.exists?(config)
      puts "  Config directory already exists"
    else
      Dir.mkdir("config")
      puts "  Created directory '#{config}'"
    end
  end

  def self.environment # checks for/creates environment file
    env = Dir.pwd + "/config/environment.rb"
    if File.exists?(env)
      puts "  Environment file already exists"
    else
      File.new(env, "w+")
      puts "  Created file '#{env}'"
    end
  end

  def self.headers
    File.open("config/environment.rb", "w+") {|file|
      file.puts "# ADD CURRENT DIR TO LOAD PATH"
      file.puts "$: << '.'"
      file.puts "\n\n"
      file.puts "# AUTO INSTALL GEMS VIA BUNDLER"
      file.puts "require 'bundler'"
      file.puts "Bundler.require" # require 'bundler/setup', Bundler.require?
      file.puts "\n\n"
      file.puts "# DATABASE"
      file.puts "DB = {:conn => SQLite3::Database.new('DATABASE')}"
      file.puts "DB.results_as_hash = true"
      file.puts "\n\n"
      file.puts "# ACTIVERECORD"
      file.puts "ActiveRecord::Base.establish_connection(
                :adapter => 'sqlite3',
                :database => 'DATABASE.sqlite'
                )"
      file.puts "\n\n"
      file.puts "# GEM DEPENDENCIES (require [gem])"
      file.puts "\n\n"
      file.puts "# FILE DEPENDENCIES (require [file])"
      file.puts "\n\n"
      file.puts "#! ACTION: Dependencies to sort"
    }
    puts "\nWriting 'environment.rb' file:"
    puts "  Added current directory to load path"
    puts "  Added bundler"
    puts "  Added database syntax"
    puts "  Added gem header"
    puts "  Added file header"
    puts "  Added to-sort header"
  end
end

Init.init
