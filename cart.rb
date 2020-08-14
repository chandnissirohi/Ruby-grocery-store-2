require_relative 'bill'
require 'terminal-table/import'


class Cart

    def initialize
        @items = []
    end

    def add_items(grocery_item)
        @items << grocery_item
    end

    def bill
        return Bill.new if @items.empty?

        total_bill = @items.map{ |item| item.unit_price }.inject(:+)
        groupHash = @items.group_by { |item| item.name }
        discounted_bill = groupHash.inject(0){ |total, (name, list)|
        total += get_discounted_price(list)
        }

        return Bill.new(total_bill, total_bill - discounted_bill)
    end

    def pricing_table
        result = [] 

        unless @items.empty?
        items_group = @items.group_by{ |item| item.name }
        items_group.each { |name, list|
        result << [ name, list.size, "$#{get_discounted_price(list)}"]    
        }
    end
        

        items_table = table { |t| 
            t.headings = "Item", "Quantity", "Price"
            result.each { |row| t << row}
        }
        
            return items_table.to_s
    end 

    private

    def get_discounted_price(groceryItemsColl)
        return 0 if groceryItemsColl.empty?

        item = groceryItemsColl[0]
        count = groceryItemsColl.size

        return count * item.unit_price if item.sale_price.nil?

        quotient = count / item.sale_qty
        remainder = count % item.sale_qty
        return (quotient * item.sale_price) + (remainder * item.unit_price)
    end

end
