# prompt: Add items to the cart
puts "Please enter all the items purchased separated by a comma"

inputs = gets.chomp

# Converting items string to an array
items = inputs.split(',')

# remove unwanted spaces in the items
items.map! { |item| item.strip }

