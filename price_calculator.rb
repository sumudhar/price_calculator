class PriceCalculator
 AVAILABLE_ITEMS = %W[MILK BREAD BANANA APPLE]

 UNIT_PRICE = {'MILK'=>3.97 ,
               'BREAD' =>2.17,
               'BANANA'=>0.99,
               'APPLE' => 0.89
              }

 SALE_PRICE = {'MILK'=> '2 for 5' ,
               'BREAD' =>'3 for 6',
               'BANANA'=>'',
               'APPLE' => ''

 }
  def input_items
    puts "Please enter all the items purchased separated by a comma "
    str = gets.chomp()
    items_count = list_items_count(str)  unless str.nil?
    compute_price = calculate_price(items_count) unless items_count.empty?
  end

 def list_items_count(str)
   h= Hash.new(0)
   str.split(',').each do |x|
    x= x.strip().upcase
     if AVAILABLE_ITEMS.include?(x)
       if h.has_key?(x)
         h[x] += 1
       else
         h[x] = 1
       end
    end
   end
  h
 end

 def calculate_price(items=nil)
   sale_price,sale_quantity,unit_quantity = {},{},{}
   items.each do  |key,value|
     if SALE_PRICE.has_key?(key.upcase)
         unit,price = SALE_PRICE[key.upcase].split('for')
         unit = unit.to_i
         if unit!=0
           sale_quantity[key.upcase] = (value-(value%unit))/unit
           unit_quantity[key.upcase] = (value%unit)
         else
           sale_quantity[key.upcase]=0
           unit_quantity[key.upcase] = value
         end
         sale_price[key.upcase] =price.to_f
     end
   end
   price = compute_total_price(items,sale_price,sale_quantity,unit_quantity)
   puts "\n\n"
   puts "Total price :$#{price["total_price"].round(2)}"
   puts "You saved :$#{(price["selling_price"]-price["total_price"]).round(2)} today "
 end

  def compute_total_price(items,sale_price,sale_quantity,unit_quantity)
    total_price = 0.0
    selling_price = 0.0
    price ={}
    puts "Item     Quantity      Price"
    puts "------------------------------------------------"
    items.each do |item,value|
      sale_value = sale_price[item]*sale_quantity[item] if sale_price.has_key?(item)
      unit_value = unit_quantity[item]*UNIT_PRICE[item] if unit_quantity.has_key?(item)
      price = sale_value + unit_value
      total_price += price
      actual_price = items[item]* UNIT_PRICE[item]
      selling_price +=actual_price
      print  "#{item}      #{value}           $#{price} \n"
    end
    price = {"total_price" =>total_price ,"selling_price"=>selling_price}
  end

end

pc = PriceCalculator.new
pc.input_items

