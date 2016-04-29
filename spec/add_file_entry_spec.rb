require 'spec_helper'
require 'pry'

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end

describe AddFileEntry do

  describe ".single" do
    it "takes in any number of files as input" do
      expect(AddFileEntry.single(@file).not_to raise_error)
    end
  end

end
