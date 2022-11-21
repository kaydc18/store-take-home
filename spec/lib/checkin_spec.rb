require "spec_helper"

RSpec.describe Checkin do
  describe ".new method" do
    it "takes item and price as arguments" do
      checkin = Checkin.new("sweaters", "$30.00")

      expect(checkin).to be_a(Checkin)
    end
  end

  let(:checkin) { Checkin.new("shirts", "30") }

  describe "#item" do
    it "returns a string and is read only" do
      expect(checkin.item).to be_a(String)
      expect(checkin.item).to eq("shirts")
      expect { checkin.item = "pajamas" }.to raise_error(NoMethodError)
    end
  end

  describe "#amount" do
    it "returns an integer" do
      jackets = Checkin.new("jackets", "4")

      expect(jackets.amount).to be_an(Integer)
      expect(jackets.amount).to eq(4)
    end
  end

  describe ".all method" do
    it "returns all Checkin instances" do
      sweatshirts = Checkin.new("sweatshirts", "50")
      
      expect(Checkin.all).to be_an(Array)
      expect(Checkin.all).to include(sweatshirts)
    end
  end

  describe ".find method" do
    it "Will find items and return nil if not found" do
      pants = Checkin.new("pants", "80") 
      item = "pants"
      false_item = "pineapples"
      
      expect(Checkin.find(item)).to eq(pants)
      expect(Checkin.find(false_item)).to eq(nil)
    end
  end

  describe ".update method" do
    it "will find and update previous instance amount" do
      old_jackets = Checkin.find("jackets")
      new_jackets = Checkin.new("jackets", "8")

      expect(old_jackets.amount).to eq(12)
    end
  end
end