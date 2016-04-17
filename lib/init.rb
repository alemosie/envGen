class Init

  attr_accessor :config

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
    puts "  gem -s [gem]  : Search partial gem name and add gem to environment"
    puts "  gem .         : Add gem shortcut $: << '.' to file"
    puts "  help          : Display this message \n"
  end

  def self.init # if not exist: write config directory and environment file
    puts "INITIALIZING CONFIG/ENVIRONMENT.RB..."
    puts "\nChecking for 'config' directory:"
    self.config
    puts "\nChecking for 'config/environment.rb' file:"
    self.environment
    self.headers
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
      file.puts "# GEM DEPENDENCIES (require [gem] or $: <<  '.')"
      file.puts "\n\n"
      file.puts "# GEM SHORTCUT - when combined with bundler, no need to add gems"
      file.puts "$: << '.'"
      file.puts "\n\n"
      file.puts "# AUTO INSTALL GEMS VIA BUNDLER"
      file.puts "require 'bundler'"
      file.puts "Bundler.require"
      file.puts "\n\n"
      file.puts "# FILE DEPENDENCIES (require_relative [file])"
    }
    puts "\nWriting 'environment.rb' file:"
    puts "  Added gem header"
    puts "  Added gem shortcut"
    puts "  Added bundler"
    puts "  Added file header"
  end
end

Init.init
