require "spec_helper"

RSpec.describe Order do
  
  describe ".new method" do
    it "will take in name, chinos, amount" do
      register = Register.new("chinos", "$15.99")
      checkin = Checkin.new("chinos", "30")
      order = Order.new("candice", "chinos", "10")
      order_two = Order.new("randal", "chinos", "90")
  
      expect(order).to be_a(Order)
    end

    it "attempt to over purchase will give an order a variable of #incomplete_order" do
      expect(order_two.incomplete_order).to eq("n/a")
    end
  end
  
  let(:register) { Register.new("chinos", "$15.99") }
  let(:checkin) { Checkin.new("chinos", "30") }
  let(:order) { Order.new("candice", "chinos", "10") }
  let(:order_two) { Order.new("randal", "chinos", "90") }

  describe "#name" do
  it "returns a string and is read only" do
      expect(order.name).to be_a(String)
      expect(order.name).to eq("Candice")
      expect { order.name = "james" }.to raise_error(NoMethodError)
    end
  end

  describe "#average_price" do
    it "returns the correct information on initial order" do
      expect(order.average_price).to eq(159.9)
    end
  end

  describe "#items_array" do
    it "returns an array and has correct information" do
      expect(order.items_array).to be_an(Array)
      expect(order.items_array).to include({ "chinos" => "159.90" })
    end

    it "can have additional items added to it" do
      register_three = Register.new("shoes", "$30.00")
      checkin_three = Checkin.new("shoes", "20")
      order_three = Order.new("candice", "shoes", "15")

      expect(order_three.items_array).to include({ "chinos" => "159.90" }, { "shoes" => "450.00" })
    end
  end

  describe ".all" do
    it "will show all records for Order" do
      order_three = Order.new("candice", "shoes", "15")

      expect(Order.all).to include(order_three)
    end
  end

  describe ".delete" do
    it "will delete a record in Order" do
      order_three = Order.new("candice", "shoes", "15")
      delete_order = Order.delete(order_three)

      expect(Order.all).not_to include(order_three)
    end
  end

  describe ".find" do
    it "will find a record in Order" do
      order_three = Order.new("candice", "shoes", "15")
      find_order = Order.find(order_three.name)
      
      expect(find_order).to eq(order_three)
    end
  end

  describe ".create_report" do
    it "will create a printed report of orders" do
      order_two = Order.new("david", "chinos", "90")
      order_four = Order.new("alyssa", "shoes", "2")
      order_five = Order.new("alyssa", "chinos", "2")
      create_report = Order.create_report
      
      expect(Order.create_report).to include("David: n/a")
      expect(Order.create_report).to include("Alyssa: shoes - $60.00, chinos - $31.98 | Average Order Value: $45.99")
    end
  end
end