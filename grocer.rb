def consolidate_cart(cart)
  new_hash = Hash.new
  cart.each do |item|
    item_name = item.keys.first
    if new_hash[item_name]
      new_hash[item_name][:count] += 1
    else
      new_hash[item_name] = item[item_name]
      new_hash[item_name][:count] = 1
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  new_hash = Hash.new
  cart.each do |item, attributes|
    new_hash[item] = attributes
    coupons.each do |coupon|
      if item == coupon[:item] && attributes[:count] >= coupon[:num]
        remainder = attributes[:count] % coupon[:num]
        new_hash["#{item} W/COUPON"] = {
          :price => coupon[:cost] / coupon[:num],
          :clearance => attributes[:clearance],
          :count =>  attributes[:count] - remainder
        }
        new_hash[item][:count] = remainder
      end
    end
  end
  new_hash
end



def apply_clearance(cart)
  cart.each do |item|
    item.each do |attributes|
      if item[:clearance] == true
        item[:price] = (item[:price] * 0.80).round(2)
      end
    end  
  end
end


def checkout(cart, coupons)
#
end
