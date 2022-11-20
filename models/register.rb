class Register
  attr_reader :item, :price
 
  @@all = []

  def initialize(item, price)
    @item = item
    @price = price.gsub("$", "").to_f
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(item)
    @@all.find { |inst| inst.item == item }
  end
end