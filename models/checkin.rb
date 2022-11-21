class Checkin
  attr_reader :item
  attr_accessor :amount

  @@all = []

  def initialize(item, amount)
    if Checkin.find(item).nil?
      @item = item
      @amount = amount.to_i
      @@all << self
    else
      found_inst = Checkin.find(item)
      Checkin.update_amount(found_inst, amount)
    end
  end

  def self.all
    @@all
  end

  def self.find(item)
    @@all.find { |inst| inst.item == item }
  end

  def self.update_amount(found_inst, amount, purchase = nil)
    if purchase.nil?
      found_inst.amount += amount.to_i
    else
      found_inst.amount -= amount.to_i
    end
  end
end