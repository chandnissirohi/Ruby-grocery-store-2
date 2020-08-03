require 'terminal-table/import'
require_relative 'constant'
require_relative 'validator'
require_relative 'grocery_item'


# prompt: Add items to the cart
puts "Please enter all the items purchased separated by a comma"

inputs = gets.chomp

# Converting items string to an array
items = inputs.split(',')

# remove unwanted spaces in the items
items.map! { |item| item.strip }

# valid-input validation
unless Validation::validateInput(items)
    exit
end

# mapping over items and converting the array of strings to symbols
items.map! { |item| Constants::GROCERY_ITEMS_MAPPINGS[item.to_sym] }

# get discounted price and total bill
def get_discounted_price(groceryItemsColl)
    return 0 if groceryItemsColl.empty?

    item = groceryItemsColl[0]
    count = groceryItemsColl.size

    if (item.sale_price.nil?)
        return count * item.unit_price
    end

    quotient = count / item.sale_qty
    remainder = count % item.sale_qty

    return (quotient * item.sale_price) + (remainder * item.unit_price)
end

def get_discounted_bill(groceryItems)
    groupHash = groceryItems.group_by { |item| item.name }
    result = groupHash.reduce(0) { |acc, (name, list)|
        acc + get_discounted_price(list)
    }
    return result
end

def pricing_table(items)

    return [] if items.empty?

    result = []
    items_group = items.group_by{ |item| item.name }
    items_group.each { |name, list|
    result << [ name, list.size, "$#{get_discounted_price(list)}"]    
    }
    result
end

total_bill = items.reduce(0) { |acc, item| 
    acc + item.unit_price}

discounted_bill = get_discounted_bill(items)
savings = total_bill - discounted_bill

puts "\n"
items_breakup = pricing_table(items)
items_table = table { |t| 
    t.headings = "Item", "Quantity", "Price"
    items_breakup.each { |row| t << row}
}
puts items_table
puts "\n"

puts "Total price:  $#{discounted_bill.round(2)}"
puts "You saved $#{savings.round(2)} today"

