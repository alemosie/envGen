require 'spec_helper'
require 'pry'

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
  end

  describe "#gemName" do
    it "returns gem name used to initalize the AddGem object" do
      expect(@restClient.gemName).to eq("rest-client")
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
    let(:config_lines) { ["rest-client"] }

    it "returns true if gem in environment.rb" do
      expect(File).to receive(:readlines).with("config/environment.rb").and_return(config_lines)
      expect(@restClient.inConfig?).to be true
    end
    it "returns false if gem not in environment.rb" do
      expect(File).to receive(:readlines).with("config/environment.rb").and_return(config_lines)
      expect(@largestRodent.inConfig?).to be false
    end
  end

  describe "#write" do
    it "writes gem to the environment" do
      file = double
      expect(File).to receive(:open).with("config/environment.rb", "a+").and_yield(file)
      expect(file).to receive(:puts).with(/rest-client/)
      @restClient.write
    end
  end

  describe "#gemEntry" do
    let(:in_config) { ["rest-client"] }
    let(:gem_string) { "prybaby" }

    it "doesn't add gem if already in environment" do
      expect(File).to receive(:readlines).with("config/environment.rb").and_return(in_config)
      expect { @restClient.gemEntry }.to output(/already added/).to_stdout
    end

    it "doesn't add gem if gem doesn't exist" do
      expect(File).to receive(:readlines).with("config/environment.rb").and_return(in_config)
      expect(@largestRodent.gemName).not_to eq(gem_string)
      expect { @largestRodent.gemEntry }.to output(/No exact match/).to_stdout
    end

    describe "adds gem if exists and not in environment" do
      it "checks if not in environment" do
        expect(File).to receive(:readlines).with("config/environment.rb").and_return(in_config)
        expect(@prybaby.inConfig?).to be false
      end
      it "checks if the gem exists" do
        expect(@prybaby.gemName).to eq(gem_string)
      end
      it "writes to environment" do
        file = double
        expect(File).to receive(:open).with("config/environment.rb", "a+").and_yield(file)
        expect(file).to receive(:puts).with(/prybaby/)
        @prybaby.write
      end
    end
  end

  describe "#gemSearch" do
    let(:exact_match) { "rest-client" }
    let(:partial_match) { "rest-client v2" }

    it "finds gems that partially match object's @gemName" do
      expect(partial_match).to include(@restClient.gemName)
    end
    it "highlights exact matches with @gemName" do
      expect(@restClient.gemName).to eq(exact_match)
      expect { @restClient.gemSearch }.to output(/\*\* #{Regexp.quote(exact_match)}/).to_stdout
    end
  end
end
