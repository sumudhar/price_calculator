require 'yaml'

module ReadData
  # This will read contents from list
  def self.available_items
    items =  @private_implementation.read_data_from_file
    available_items = []
    items['items_list'].each { |item| available_items << item['name'].upcase } unless items.empty?
    available_items
  end

  def self.sale_price
    data =   @private_implementation.read_data_from_file
    sale_price ={}
    data['items_list'].each do |item|
      name = item['name'].upcase
      if item['sale_price'].nil?
        sale_price[name] = ''
      else
        sale_price[name] = item['sale_price']
      end
    end unless data.empty?
    sale_price
  end

# This method is used to get the all the unit prices given for the products
  def self.unit_price
    data =   @private_implementation.read_data_from_file
    unit_price ={}
    data['items_list'].each do |item|
      name = item['name'].upcase
      unit_price[name] = item['unit_price']
    end unless data.empty?
    unit_price
  end


  @private_implementation = Module.new do
    def self.read_data_from_file
      config ={}
      file_name = "./read_data.yml"
      unless File.exists? (file_name)
        puts "Properties file not found"
      else
        config = YAML.load_file(file_name)
      end
      config
    end
  end


end