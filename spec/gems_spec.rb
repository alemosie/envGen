require 'spec_helper'

describe Gems do

  describe "initialize" do
    it "takes one gem name" do
      expect { Gems.new("rest-client") }.not_to raise_error
    end
  end

  describe "exactGem?" do
    it "takes in one argument" do
      gem = Gems.new("rest-client")
      gemString = "rest-client"
      expect { gem.exactGem?("gemSearchString") }.not_to raise_error
    end
  end

  # describe "write" do
  #   file = double(Gems.write)
  #   expect(File).to receive(:open).with("config/environment.rb", "w+").and_yield(file)
  #   expect(file).to receive(:puts).with(/gem/)
  # end
end
