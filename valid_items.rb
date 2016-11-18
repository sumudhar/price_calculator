module  ValidItems
  # This method will check the weather the available items are valid or not

  def self.validate_items_list(str=nil,available_items)
    return  if str.nil?
    h= Hash.new(0)
    str.split(',').each do |x|
      x= x.strip().upcase
      if available_items.include?(x)
        if h.has_key?(x)
          h[x] += 1
        else
          h[x] = 1
        end
      end
    end
    h
  end


end