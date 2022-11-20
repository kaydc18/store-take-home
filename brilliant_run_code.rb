require 'pry'
require_relative 'models/register'
require_relative 'models/checkin'
require_relative 'models/order'

begin
  split_line = []
  File.foreach(ARGV[0]) do |line|
    split_line = line.split(" ")
    if split_line.count <= 3
      Object.const_get((split_line.first).capitalize).new(split_line[1], split_line[2])
    else
      Object.const_get((split_line.first).capitalize).new(split_line[1], split_line[2], split_line[3])
    end
  end
rescue
  print "Something is wrong with the input file, or we are missing a class file" 
end

begin
  order_text = ""
  Order.all.each do |order|
    if order.incomplete_order.nil?
      items_string = ""
      order.items_array.each do |item|
        item.each do |key, value|
          item_comma = ""
          if order.items_array.count > 1 && (order.items_array.count)-1 > order.items_array.index(item)
            item_comma = ","
          end
          items_string += " #{key} - $#{value}#{item_comma}"
        end
      end
      order_text = "#{order.name}:#{items_string} | Average Order Value: $#{order.average_price.to_s}"
    else
      order_text = "#{order.name}: #{order.incomplete_order}"
    end
     print "#{order_text}" "\n"
  end
rescue
  print "Somthing went wrong building the receipt text"
end