require "spec_helper"

RSpec.describe CreateReportHelper do
  describe ".create_report" do
    it "will create a printed report of orders" do\
      register = Register.new("chinos", "$15.99")
      checkin = Checkin.new("chinos", "30")
      order = Order.new("candice", "chinos", "10")
      order = Order.new("candice", "chinos", "80")
      order_two = Order.new("randal", "chinos", "90")
      create_report = CreateReportHelper.create_report
      
      expect(create_report).to include("Randal: n/a")
      expect(create_report).to include("Candice: chinos - $159.90 | Average Order Value: $159.9")
    end
  end
end