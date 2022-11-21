require_relative "register"
require_relative "checkin"

class Order
  attr_reader :name
  attr_accessor :items_array, :incomplete_items, :average_price

  @@all = []

  def initialize(name, item, amount)
    @name = name.capitalize
    @items_array = []
    @incomplete_items = []
    @average_price = 0
    if Checkin.find(item).amount >= amount.to_f
      create_average(item, amount)
      unless Checkin.find(item).nil?
        found_inst = Checkin.find(item)
        Checkin.update_amount(found_inst, amount, "purchase")
      end
    else
      incomplete_orders(item, "n/a")
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
    @average_price = average / @items_array.count
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

  def incomplete_orders(item, text)
    unless Order.find(@name).nil?
      current_order = Order.find(@name)
      @average_price = current_order.average_price
      @items_array += current_order.items_array
      @incomplete_items << { item => text }
      Order.delete(current_order)
    end

    @incomplete_items << { item => text }
  end
end