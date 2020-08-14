require 'terminal-table/import'
require_relative 'constant'
require_relative 'validator'
require_relative 'grocery_item'
require_relative 'bill'
require_relative 'cart'

puts "Please enter all the items purchased separated by a comma"

inputs = gets.chomp
items = inputs.split(',')
items.map! { |item| item.strip }

unless Validation::validate_input(items)
    exit
end

cart = Cart.new
items.each { |item|  
grocery_item = Constants::GROCERY_ITEMS_MAPPINGS[item.to_sym]
cart.add_items(grocery_item) unless grocery_item.nil?
}

puts "\n"
puts cart.pricing_table
puts "\n"

bill = cart.bill
puts "Total price: $#{bill.discounted_total.round(2)}"
puts "You saved: $#{bill.discount.round(2)} today"


