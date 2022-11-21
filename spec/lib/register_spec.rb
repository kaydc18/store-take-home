require "spec_helper"

RSpec.describe Register do
  describe ".new method" do
    it "takes item and price as arguments" do
      register = Register.new("sweaters", "$30.00")

      expect(register).to be_a(Register)
    end
  end

  let(:register) { Register.new("shirts", "$15.99") }
  let(:register_two) { Register.new("watches", "$300.00") }

  describe "#item" do
    it "returns a string and is read only" do
      expect(register.item).to be_a(String)
      expect(register.item).to eq("shirts")
      expect { register.item = "pajamas" }.to raise_error(NoMethodError)
    end
  end

  describe "#price" do
    it "returns an integer" do
      register_socks = Register.new("socks", "$5.99")
      
      expect(register_socks.price).to be_an(Float)
      expect(register_socks.price).to eq(5.99)
    end
  end

  describe ".all method" do
    it "returns all Register instances" do
      expect(Register.all).to be_an(Array)
      expect(Register.all).to include(register_two)
    end
  end

  describe ".find method" do
    it "will find items and return nil if not found" do
      new_register = Register.new("slippers", "$30.00") 
      item = "slippers"
      false_item = "pineapples"

      expect(Register.find(item)).to eq(new_register)
      expect(Register.find(false_item)).to eq(nil)
    end
  end

  describe ".update method" do
    it "will find and update previous instance amount" do
      old_socks = Register.find("socks")
      new_socks = Register.new("socks", "$8.00")

      expect(old_socks.price).to eq(8.0)
    end
  end
end