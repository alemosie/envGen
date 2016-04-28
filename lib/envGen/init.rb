class Init

  attr_accessor :config

  def self.usage
    puts "\nUSAGE:\n  envGen [option]"
  end

  def self.help
    usage
    puts "\nOPTIONS:"
    puts "  init                : Initialize environment.rb file"
    puts "  file [file], [file] : Add file to environment, e.g. 'lib/test1.rb'"
    puts "  dir [dir]           : Add all .rb files in directory to environment"
    puts "  gem [gem], [gem]    : Add gem to environment using exact name"
    puts "  gem -s [gem]        : Search on partial gem name"
    puts "  help                : Display this message \n"
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
      file.puts "# AUTO INSTALL GEMS VIA BUNDLER\nrequire 'bundler'\nBundler.require
      \n\n# GEM DEPENDENCIES (require [gem])
      \n\n# FILE DEPENDENCIES (require [file])
      \n\n#! ACTION: Dependencies to sort"
    }
    puts "\nWriting 'environment.rb' file:
  Added bundler
  Added gem header
  Added file header
  Added to-sort header"
  end
end
