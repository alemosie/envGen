require 'pry'

class AddGem
  attr_accessor :gemName, :gemsFound

  @@gems = `gem list --remote`.split("\n") # gets updated list of all current RubyGems gems

  def self.gems
    @@gems
  end

  def initialize(input) # input is gem name, called with @gemName
    @gemName = input
  end

  def inConfig? # looks through environment for gem
    # binding.pry
    File.readlines("config/environment.rb").grep("gem '#{gemName}'\n").count > 0
  end

  def exactGem?(gemString) # takes in a search term and a gem to match against
    gemString.split(" ").first == gemName.downcase
  end

  def gemExists?
    @@gems.select {|gem| gem.split(" ").first == gemName }.count > 0
  end

  def write
    File.open("config/environment.rb", "a") {|env|
      env.puts "gem '#{gemName}'"
    }
  end

  def writeExactGem
    write
    puts "Added '#{gemName}'"
  end

  def noExactGem
    puts "No exact match for '#{gemName}' found"
    puts "Search for partial gem name with 'gem -s [gem]'"
  end

  def gemEntry # handles gem entry
    if !inConfig? && gemExists?
      writeExactGem
    elsif inConfig? && gemExists? # add gem if doesn't exist
      puts "'#{gemName}' already added"
    else
      noExactGem
    end
  end

  def findPartialNames # partial name search
    gemsFound = []
    puts "Searching through #{@@gems.count} gems..."
    AddGem.gems.each do |gemString| # searching through gems + version numbers
      if exactGem?(gemString)
        gemsFound.unshift("** #{gemString}") # highlights exact match
      elsif gemString.include?(gemName.downcase)
        gemsFound << gemString
      end
    end
    gemsFound
  end

  def gemSearch
    gemsFound = findPartialNames
    if gemsFound.count == 0
      puts "No exact match for '#{gemName.downcase}' found"
    else
      puts "\nFound #{gemsFound.count} gems:"
      gemsFound.each {|gem| puts gem}
    end
  end
end
