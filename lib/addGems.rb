require 'pry'

class Gems

  @@gems = `gem list --remote`.split("\n")

  def self.exactGem?(gemString, gem)
    gemString.split(" ").first == gem.downcase
  end

  def self.gem(gem) # add gem if value is exact match
    gemFound = ""

    @@gems.each do |gemString|
      if exactGem?(gemString, gem)
        self.write(gem)
        puts "Added '#{gem}' to config/environment.rb"
        gemFound = gem
      end
    end

    if gemFound == ""
      puts "No exact match for '#{gem}' found"
      puts "Search for partial gem name with 'gem -s [gem]'"
    end
  end

  def self.gemSearch(gem)
    puts "Searching through #{@@gems.count} gems..."
    gemsFound = []

    @@gems.each do |gemString| # searching through gems + version numbers
      if exactGem?(gemString, gem)
        gemsFound.unshift("** #{gemString}")
        # binding.pry
      elsif gemString.include?(gem.downcase)
        gemsFound << gemString
      end
    end

    if gemsFound == []
      puts "No exact match for '#{gem.downcase}' found"
    else
      puts "\nFound #{gemsFound.count} gems:"
      gemsFound.each {|gem| puts gem}
    end
  end

  def self.write(gem) # need to figure out how to write in the middle of a file
    File.open("config/environment.rb", "a+") {|env|
      env.puts "gem '#{gem}'"
    }
  end
end

Gems.gem("activerecord")
