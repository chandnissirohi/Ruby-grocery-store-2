require_relative 'grocery_item'

module Constants
    GROCERY_ITEMS_MAPPINGS = {
        :milk => GroceryItem.new('Milk', 3.97, 5.00, 2),
        :bread => GroceryItem.new('Bread', 2.17, 6.00, 3),
        :apple => GroceryItem.new('Apple', 0.89),
        :banana => GroceryItem.new('Banana', 0.99)
    }    
end
