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
    it "returns an integer and is read only" do
      expect(checkin.amount).to be_an(Integer)
      expect(checkin.amount).to eq(30)
      expect { checkin.amount = 27 }.to raise_error(NoMethodError)
    end
  end

  describe ".all method" do
    it "returns all Checkin instances" do
      expect(Checkin.all).to be_an(Array)
      expect(Checkin.all).to include(checkin)
    end
  end

  describe ".find method" do
    it "Will find items and return nil if not found" do
      new_checkin = Checkin.new("pants", "80") 
      item = "pants"
      false_item = "pineapples"
      
      expect(Checkin.find(item)).to eq(new_checkin)
      expect(Checkin.find(false_item)).to eq(nil)
    end
  end
end