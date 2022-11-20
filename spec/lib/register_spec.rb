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
    it "returns an integer and is read only" do
      expect(register.price).to be_an(Float)
      expect(register.price).to eq(15.99)
      expect { register.price = 13.0 }.to raise_error(NoMethodError)
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
end