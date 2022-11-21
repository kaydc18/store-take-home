require_relative "models/order"

module CreateReportHelper 

  def self.create_report
    order_text = []
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
        order_text << "#{order.name}:#{items_string} | Average Order Value: $#{order.average_price.to_s}"
      else
        order_text << "#{order.name}: #{order.incomplete_order}"
      end
    end
    order_text
  end
end