class AddGem
  attr_accessor :gemName

  @@gems = `gem list --remote`.split("\n") # gets updated list of all current RubyGems gems

  def initialize(input) # input is gem name, called with @gemName
    @gemName = input
    @gemFound = ""
  end

  def inConfig? # looks through environment for gem
    File.readlines("config/environment.rb").grep(/#{@gemName}/).size > 0
  end

  def exactGem?(gemString) # takes in a search term and a gem to match against
    gemString.split(" ").first == @gemName.downcase
  end

  def write
    File.open("config/environment.rb", "a+") {|env|
      env.puts "gem '#{gemName}'"
    }
  end

  def findExactGem(gemNameInput)
    @gemFound = @@gems.select { |gemString| gemString.split(" ").first == gemNameInput}
  end

  def writeExactGem(gemString)
    if exactGem?(gemString)
      self.write
      puts "Added '#{gemName}' to config/environment.rb"
    end
  end

  def noExactGem
    puts "No exact match for '#{gemName}' found"
    puts "Search for partial gem name with 'gem -s [gem]'"
  end

  def gemEntry # handles gem entry
    gemFound = ""
    if !self.inConfig?
      @@gems.each do |gemString| # add gem if exists
        if exactGem?(gemString)
          self.write
          puts "Added '#{@gemName}' to config/environment.rb"
          gemFound = @gemName
        end
      end
      if gemFound == "" # add gem if doesn't exist
        puts "No exact match for '#{@gemName}' found"
        puts "Search for partial gem name with 'gem -s [gem]'"
      end
    else
      puts "'#{@gemName}' already added"
    end
  end

  def gemSearch # partial name search
    puts "Searching through #{@@gems.count} gems..."
    gemsFound = []
    @@gems.each do |gemString| # searching through gems + version numbers
      if exactGem?(gemString)
        gemsFound.unshift("** #{gemString}") # highlights exact match
      elsif gemString.include?(@gemName.downcase)
        gemsFound << gemString
      end
    end
    if gemsFound == []
      puts "No exact match for '#{@gemName.downcase}' found"
    else
      puts "\nFound #{gemsFound.count} gems:"
      gemsFound.each {|gem| puts gem}
    end
  end
end
