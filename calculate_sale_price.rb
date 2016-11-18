module CalculateSalePrice

# this module wil check that sale price and items list  applies for sale....

  def self.apply_sale_price_on_each_item(items,sale_unit_price)
  return {"sale_price"=>{},"sale_quantity"=>{},"unit_quantity"=>{}}  if items.nil?
  sale_price,sale_quantity,unit_quantity,result = {},{},{},{}
  items.each do  |key,value|
    if sale_unit_price.has_key?(key.upcase)
      unit,price = sale_unit_price[key].split('for')
      unit = unit.to_i
      if unit!=0
        sale_quantity[key] = (value-(value%unit))/unit
        unit_quantity[key] = (value%unit)
      else
        sale_quantity[key]=0
        unit_quantity[key] = value
      end
      sale_price[key] =price.to_f.round(2)
    end
  end
  result["sale_price"] = sale_price
  result["sale_quantity"] = sale_quantity
  result["unit_quantity"] = unit_quantity
  return result
end


end