require 'pry'
require_relative "addFiles.rb"
require_relative "init.rb"
require_relative "gems.rb"

class Args

  @@options = ["init", "file", "dir", "gem", "help"]


  def self.parse
    # binding.pry
    if !@@options.include?(ARGV[0])
      puts "invalid command"
    else
      # binding.pry
      case ARGV[0]
      when "init"
        Init.init
      when "file"
        ARGV.delete_at(0)
        ARGV.each do |arg|
          AddFiles.single(arg)
        end
      when "dir"
        ARGV.delete_at(0)
        ARGV.each do |arg|
          AddFiles.multiple(arg)
        end
      when "gem"
        ARGV.delete_at(0)
        if ARGV[0] == "-s"
          Gems.gemSearch(ARGV[1])
        else
          ARGV.each do |arg|
            Gems.gem(arg)
          end
        end
      when "help"
        Init.help
      end
    end
  end

end
