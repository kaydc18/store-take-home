require_relative "register"
require_relative "checkin"

class Order
  attr_reader :name, :incomplete_order
  attr_accessor :items_array, :average_price

  @@all = []

  def initialize(name, item, amount)
    @name = name.capitalize
    if Checkin.find(item).amount >= amount.to_f
      @items_array = []
      @average_price = create_average(item, amount)
    else
      @incomplete_order = "n/a"
    end
    @@all << self
  end
  
  def self.all
    @@all
  end

  def self.delete(order)
    @@all.delete(order)
  end

  def self.find(name)
    @@all.find { |inst| inst.name == name }
  end

  def create_average(item, amount)
    add_items_and_price(item, amount)
    average = 0
    @items_array.each do |item|
      average += item.values[0].to_f
    end
    average / @items_array.count
  end

  def add_items_and_price(item, amount)
    price_total = (Register.find(item).price * amount.to_f)
    price_total_convert = sprintf('%.2f', price_total)
    unless Order.find(@name).nil?
      @items_array += Order.find(@name).items_array
      Order.delete(Order.find(@name))
    end

    @items_array << { item => price_total_convert }
  end
end