require 'spec_helper'
require 'pry'

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end

describe AddFile do
  before(:all) { @file = "/Users/asiega/Development/immersive/personal-projects/envGen/lib/envGen.rb"}

  describe ".single" do
    it "handles case where file is valid, Ruby, and not in environment and calls write" do
      new_file = double
      expect(PrepareFile).to receive(:createIfNotInConfig).with(@file).and_return(new_file) # command to return!
      expect(new_file).to receive(:file).and_return(@file)
      expect(File).to receive(:file?).with(@file).and_return(true)
      expect(new_file).to receive(:isRuby?).and_return(true)
      expect(new_file).to receive(:write)
      AddFile.single(@file)
    end

    it "handles case where valid, not in environment, and not Ruby" do
      new_file = double
      expect(PrepareFile).to receive(:createIfNotInConfig).with(@file).and_return(new_file) # command to return!
      expect(new_file).to receive(:file).and_return(@file)
      expect(File).to receive(:file?).with(@file).and_return(true)
      expect(new_file).to receive(:isRuby?).and_return(false)
      expect(new_file).to receive(:notRuby)
      AddFile.single(@file)
    end
  end

  describe ".dir" do
    let(:dir) { "directory"}
    let(:invalid) { "/Users/asiega/Development/immersive/personal-projects/real.txt"}
    let(:notReal) { "/Users/asiega/Development/immersive/personal-projects/notReal.rb"}
    let(:files) { [@file, invalid, notReal] }

    it "calls .single for all Ruby files found in a directory" do
      expect(AddFile).to receive(:findRuby).with(dir).and_return(files) # commanding, not expecting
      expect(File).to receive(:file?).with(@file).and_return(true)
      expect(File).to receive(:file?).with(notReal).and_return(false)
      expect(AddFile).to receive(:single).with(@file)
      AddFile.dir(dir)
    end
  end

end
