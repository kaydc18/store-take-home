require_relative "models/order"

module CreateReportHelper 

  def self.create_report
    order_text = []
    Order.all.each do |order|
      if !order.items_array.empty?
        items_string = ""
        order.items_array.each do |item|
          item.each do |key, value|
            item_comma = ""
            order_count = order.items_array.count
            if order_count > 1 && order_count - 1 > order.items_array.index(item)
              item_comma = ","
            end
            items_string += " #{key} - $#{value}#{item_comma}"
          end
        end
        order_text << "#{order.name}:#{items_string} | Average Order Value: $#{order.average_price.to_s}"
      elsif !order.incomplete_items.empty?
        order_text << "#{order.name}: #{order.incomplete_items.first.values[0]}"
      end
    end
    order_text
  end
end