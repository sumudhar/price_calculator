load 'valid_items.rb'
load 'items_price.rb'
load 'read_data.rb'

class PriceCalculator < ItemsPrice
  def initialize
    @available_items = ReadData.available_items
  end

  def input_items
    unless @available_items.empty?
      puts "Please enter all the items purchased separated by a comma "
      str = gets.chomp()
      items_count = ValidItems.validate_items_list(str,@available_items)  unless str.nil?
      unless items_count.empty?
      #puts "valid Items from given Input :#{items_count}"
      price = calculate_price(items_count)
      puts "\n\n"
      puts "Total price :$#{price["total_price"].round(2)}\n"
      puts "You saved :$#{(price["selling_price"]-price["total_price"]).round(2)} today\n\n "
      else
      puts "Valid Items are #{@available_items}"
      end
    else
      puts "Available Items list not available"
    end
  end

end

PriceCalculator.new.input_items
