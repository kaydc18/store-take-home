class Register
  attr_reader :item
  attr_accessor :price
 
  @@all = []

  def initialize(item, price)
    if Register.find(item).nil?
      @item = item
      @price = price.gsub("$", "").to_f
      @@all << self
    else
      found_inst = Register.find(item)
      Register.update_price(found_inst, price)
    end
  end


  def self.all
    @@all
  end

  def self.find(item)
    @@all.find { |inst| inst.item == item }
  end

  def self.update_price(found_inst, price)
    found_inst.price = price.gsub("$", "").to_f
  end
end