class AddGem
  attr_accessor :gem

  @@gems = `gem list --remote`.split("\n") # gets updated list of all current RubyGems gems

  def initialize(gem)
    @gem = gem
  end

  def inConfig? # looks through environment for gem
    File.readlines("config/environment.rb").grep(/#{@gem}/).size > 0
  end

  def exactGem?(gemString) # takes in a search term and a gem to match against
    gemString.split(" ").first == @gem.downcase
  end

  def write
    File.open("config/environment.rb", "a+") {|env|
      env.puts "gem '#{@gem}'"
    }
  end

  def gem # add gem if value is exact match
    gemFound = ""
    if !self.inConfig?
      @@gems.each do |gemString|
        if exactGem?(gemString)
          self.write
          puts "Added '#{@gem}' to config/environment.rb"
          gemFound = @gem
        end
      end
      if gemFound == ""
        puts "No exact match for '#{@gem}' found"
        puts "Search for partial gem name with 'gem -s [gem]'"
      end
    else
      puts "'#{@gem}' already added"
    end
  end

  def gemSearch # partial name search
    puts "Searching through #{@@gems.count} gems..."
    gemsFound = []
    @@gems.each do |gemString| # searching through gems + version numbers
      if exactGem?(gemString)
        gemsFound.unshift("** #{gemString}") # highlights exact match
      elsif gemString.include?(@gem.downcase)
        gemsFound << gemString
      end
    end
    if gemsFound == []
      puts "No exact match for '#{@gem.downcase}' found"
    else
      puts "\nFound #{gemsFound.count} gems:"
      gemsFound.each {|gem| puts gem}
    end
  end
end
