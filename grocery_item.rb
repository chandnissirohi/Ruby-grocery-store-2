class GroceryItem
    attr_reader :name, :unit_price, :sale_price, :sale_qty

    def initialize(name, unit_price, sale_price=nil, sale_qty=nil)
        @name = name
        @unit_price = unit_price
        @sale_price = sale_price
        @sale_qty = sale_qty
    end
end