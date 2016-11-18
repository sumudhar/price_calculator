load 'calculate_sale_price.rb'
load 'read_data.rb'

class ItemsPrice


  def calculate_price(items=nil)
   sale_unit_price = ReadData.sale_price
   price_after_applying_sale_price = CalculateSalePrice.apply_sale_price_on_each_item(items,sale_unit_price)  # check that we need to apply the sale price for items
   price = compute_total_price(items,price_after_applying_sale_price)
   price
 end


 private

 def compute_total_price(items,price_after_applying_sale_price)
   per_unit_price = ReadData.unit_price
   sale_price=price_after_applying_sale_price["sale_price"]
   sale_quantity=price_after_applying_sale_price["sale_quantity"]
   unit_quantity=price_after_applying_sale_price["unit_quantity"]
   total_price = 0.0
   selling_price = 0.0
   puts "\n---------------------------------------"
   puts "%2s  %10s %10s" %["Item","Quantity","Price"]
   puts "---------------------------------------"
   items.each do |item,value|
     sale_value = sale_price[item]*sale_quantity[item] if sale_price.has_key?(item)
     unit_value = unit_quantity[item]*per_unit_price[item] if unit_quantity.has_key?(item)
     price = sale_value + unit_value
     total_price += price.round(2)
     actual_price = items[item]* per_unit_price[item]
     selling_price +=actual_price
     s = "%s  %#{10-item.size}s %#{(14)}s" % [item,value,"$"+price.round(2).to_s]
     puts s
   end
   price = {"total_price" =>total_price ,"selling_price"=>selling_price}
 end

end