require 'spec_helper'
require 'pry'

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end

describe PrepareFile do
  before(:all) { @file = "/Users/asiega/Development/immersive/personal-projects/envGen/lib/envGen.rb"}
  before(:all) { @fileName = "envGen.rb"}
  before(:all) { @validFileObject = PrepareFile.new(@file) }
  before(:all) { @invalidFile = "/Users/asiega/Development/immersive/personal-projects/notReal.rb"}
  before(:all) { @invalidFileObject = PrepareFile.new(@invalidFile) }

  describe "#initialize" do
    it "takes in one argument, a full file path/name" do
      expect { @validFileObject }.not_to raise_error
    end
    it "creates @file from full file path/name" do
      # binding.pry
      expect(@validFileObject.file).to eq(@file)
    end
    it "creates @fileName from file name" do
      expect(@validFileObject.fileName).to eq(@fileName)
    end
  end

  describe ".inConfig?" do
    before(:each) { expect(File).to receive(:readlines).with("config/environment.rb").and_return([@fileName]) } # grep must return an array of matches

    it "returns true if file in environment.rb" do
      expect(PrepareFile.inConfig?(@file)).to be true
    end
    it "returns false if file not in environment.rb" do
      # binding.pry
      expect(PrepareFile.inConfig?(@invalidFile)).to be false
    end
  end

  describe ".createIfNotInConfig" do
    context "file not in environment" do
      it "#inConfig returns false" do
        expect(File).to receive(:readlines).with("config/environment.rb").and_return([@fileName])
        expect(PrepareFile.inConfig?(@invalidFile)).to be false
      end
      it "creates new PrepareFile object" do
        expect(PrepareFile.new(@file)).to be_an_instance_of(PrepareFile)
      end
    end
    context "file in environment" do
      before(:each) { expect(File).to receive(:readlines).with("config/environment.rb").and_return([@fileName]) } # grep must return an array of matches
      it "#inConfig returns true" do
        expect(PrepareFile.inConfig?(@file)).to be true
      end
      it "tells the user that file is in environment" do
        expect { PrepareFile.createIfNotInConfig(@file) }.to output(/already added/).to_stdout
      end
    end
  end

  describe "#write" do
    it "writes file to the environment" do
      file = double
      expect(File).to receive(:open).with("config/environment.rb", "a").and_yield(file)
      expect(file).to receive(:puts).with(/#{@fileName}/)
      @validFileObject.write
    end
  end

  describe "#isRuby?" do
    it "returns only files with a .rb extension" do
      expect(@validFileObject.isRuby?).to be true
    end
  end

  describe "#notRuby" do
    it "adds file to environment with user permission" do
      allow(@validFileObject).to receive(:gets) { "Y" } # the new version of "stub"
      expect(@validFileObject).to receive(:write)
      @validFileObject.notRuby
    end
    it "doesn't add file in any other case" do
      allow(@validFileObject).to receive(:gets) { "N" }
      expect(@validFileObject.notRuby).to eq(puts "'#{@validFileObject.fileName}' not added")
    end
  end

  describe "#relativePath" do
    let(:path) { "../lib/#{@fileName}" }
    it "creates relative path from config/environment.rb for PrepareFile object" do
      expect(@validFileObject.relativePath).to eq(path)
    end
  end
end
