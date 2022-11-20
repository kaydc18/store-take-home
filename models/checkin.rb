class Checkin
  attr_reader :item, :amount
  @@all = []

  def initialize(item, amount)
    @item = item
    @amount = amount.gsub("$","").to_i
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(item)
    @@all.find { |inst| inst.item == item }
  end
end