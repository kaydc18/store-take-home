require "pry"
require_relative "models/register"
require_relative "models/checkin"
require_relative "models/order"
require_relative "create_report_helper"

begin
  split_line = []
  File.foreach(ARGV[0]) do |line|
    split_line = line.split(" ")
    
    constant_line = split_line.first.capitalize

    if split_line.count == 3
      Object.const_get(constant_line).new(split_line[1], split_line[2])
    else
      Object.const_get(constant_line).new(split_line[1], split_line[2], split_line[3])
    end
  end

  CreateReportHelper.create_report.each do |order|
    print "#{order}\n"
  end
rescue => e
  print "Something is wrong with the input file, classes, or create report module: #{e}"
end
