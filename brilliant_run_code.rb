require 'pry'
require_relative 'models/register'
require_relative 'models/checkin'
require_relative 'models/order'

begin
  split_line = []
  File.foreach(ARGV[0]) do |line|
    split_line = line.split(" ")
    if split_line.count == 3
      Object.const_get((split_line.first).capitalize).new(split_line[1], split_line[2])
    else
      Object.const_get((split_line.first).capitalize).new(split_line[1], split_line[2], split_line[3])
    end
  end
rescue
  print "Something is wrong with the input file, or we are missing a class file" 
end

begin
  Order.create_report.each do |order|
    print order + "\n"
  end
rescue
  print "Somthing went wrong building the receipt text"
end