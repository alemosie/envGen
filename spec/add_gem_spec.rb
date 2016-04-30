require 'spec_helper'

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end

describe AddGem do
  before(:all) { @restClient = AddGem.new("rest-client") }
  before(:all) { @largestRodent = AddGem.new("largest-rodent") } # capybara reference! :)
  before(:all) { @prybaby = AddGem.new("prybaby")}

  describe "#initialize" do
    it "takes in one argument, a gem name" do
      expect { AddGem.new("rest-client") }.not_to raise_error
    end
    it "creates @gemName from input" do
      name = "rest-client"
      expect(@restClient.gemName).to eq(name)
    end
  end

  describe "#exactGem?" do
    it "takes in one argument, a line from the full gem list" do
      expect { @restClient.exactGem?("gemSearchString") }.not_to raise_error
    end
    it "matches @gemName to input" do
      gemString = "rest-client"
      expect(@restClient.gemName).to eq(gemString)
    end
  end

  describe "#inConfig?" do
    let(:config_lines) { ["gem 'rest-client'\n"] }
    before(:each) { expect(File).to receive(:readlines).with("config/environment.rb").and_return(config_lines) }

    it "true if gem in environment.rb" do
      expect(@restClient.inConfig?).to be true
    end
    it "false if gem not in environment.rb" do
      expect(@largestRodent.inConfig?).to be false
    end
  end

  describe "#write" do
    it "writes gem to the environment" do
      file = double
      expect(File).to receive(:open).with("config/environment.rb", "a").and_yield(file)
      expect(file).to receive(:puts).with(/rest-client/)
      @restClient.write
    end
  end

  describe "#gemEntry" do
    it "doesn't add gem if already in environment" do
      expect(@restClient).to receive(:gemExists?).and_return(true)
      expect(@restClient).to receive(:inConfig?).exactly(2).times.and_return(true) # goes through if, goes through elsif
      expect { @restClient.gemEntry }.to output(/already added/).to_stdout
    end

    it "doesn't add gem if gem doesn't exist and not in environment" do
      expect(@largestRodent).to receive(:gemExists?).and_return(false)
      expect(@largestRodent).to receive(:inConfig?).exactly(2).times.and_return(false)
      expect(@largestRodent).to receive(:noExactGem)
      @largestRodent.gemEntry
    end

    it "adds gem if exists and not in environment" do
      expect(@prybaby).to receive(:gemExists?).and_return(true)
      expect(@prybaby).to receive(:inConfig?).and_return(false)
      expect(@prybaby).to receive(:writeExactGem)
      @prybaby.gemEntry
    end
  end

  describe "#gemSearch" do
    let(:matches) { ["rest-client", "adamwiggins-rest-client"]}
    it "prints out all partial matches of input given" do
      expect(AddGem).to receive(:gems).and_return(matches)
      expect { @restClient.gemSearch }.to output(/#{matches[0]}/).to_stdout
    end
  end
end
