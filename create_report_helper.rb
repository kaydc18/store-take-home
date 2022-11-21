require_relative "models/order"

module CreateReportHelper 

  def self.create_report
    order_text = []

    Order.all.each do |order|
      if !order.items_array.empty?
        items_string = ""
        item_comma = ""
        items_combo = ""

        order.items_array.each_with_index do |item_hash, index|
          unless index == order.items_array.length - 1
            item_comma = ","
          end

          item_hash.each_pair { |key, value| items_string = "#{key} - $#{value}" }

          items_combo += " #{items_string}#{item_comma}"
        end

        order_text << "#{order.name}:#{items_combo} | Average Order Value: $#{order.average_price}"
      elsif !order.incomplete_items.empty?
        order_text << "#{order.name}: #{order.incomplete_items.first.values[0]}"
      end
    end

    order_text
  end
end