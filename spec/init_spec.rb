require 'spec_helper'

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end

describe Init do
  describe ".usage" do
    it "gives users a template for usage" do
      expect { Init.usage }.to output(/envGen \[option\]/).to_stdout
    end
  end

  describe ".help" do
    it "gives users a template for usage" do
      expect { Init.usage }.to output(/envGen \[option\]/).to_stdout
    end
    it "has options header" do
      expect { Init.help}.to output(/OPTIONS/).to_stdout
    end

    describe "explains options" do
      it "has instructions for init" do
        expect { Init.help }.to output(/init/).to_stdout
      end
      it "has instructions for file" do
        expect { Init.help }.to output(/file/).to_stdout
      end
      it "has instructions for dir" do
        expect { Init.help }.to output(/dir/).to_stdout
      end
      it "has instructions for gem" do
        expect { Init.help }.to output(/gem/).to_stdout
        expect { Init.help }.to output(/gem -s/).to_stdout
      end
      it "has instructions for help" do
        expect { Init.help }.to output(/help/).to_stdout
      end
    end
  end

  describe ".config" do
    it "config directory exists" do
      expect(File).to be_directory("config")
    end
  end

  describe ".environment" do
    it "environment.rb files exists" do
      expect(File).to exist("config/environment.rb")
    end
  end

  describe ".headers" do
    it "added bundler" do
      file = double(Init.headers)
      expect(File).to receive(:open).with("config/environment.rb", "w+").and_yield(file)
      expect(file).to receive(:puts).with(/require 'bundler'\nBundler.require/)
      expect { Init.headers }.to output(/Added bundler/).to_stdout
    end
    it "added gem header" do
      file = double(Init.headers)
      expect(File).to receive(:open).with("config/environment.rb", "w+").and_yield(file)
      expect(file).to receive(:puts).with(/GEM DEPENDENCIES/)
      expect { Init.headers }.to output(/Added gem header/).to_stdout
    end
    it "added file header" do
      file = double(Init.headers)
      expect(File).to receive(:open).with("config/environment.rb", "w+").and_yield(file)
      expect(file).to receive(:puts).with(/FILE DEPENDENCIES/)
      expect { Init.headers }.to output(/Added file header/).to_stdout
    end
    it "added to-sort header" do
      file = double(Init.headers)
      expect(File).to receive(:open).with("config/environment.rb", "w+").and_yield(file)
      expect(file).to receive(:puts).with(/Dependencies to sort/)
      expect { Init.headers }.to output(/Added file header/).to_stdout
    end
  end

  describe ".init" do
    it "checks for config directory" do
      expect(File).to be_directory("config")
    end
    it "checks for environment file" do
      expect(File).to exist("config/environment.rb")
    end
    it "writes environment file template" do
      file = double(Init.headers)
      expect(File).to receive(:open).with("config/environment.rb", "w+").and_yield(file)
      expect(file).to receive(:puts).with(/AUTO INSTALL/)
      expect { Init.headers }.to output(/Added bundler/).to_stdout
    end
  end
end
