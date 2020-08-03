module Validation

    def self.validateInput(items)
        if items.empty?
            puts 'Please add items to the cart'
            return false
        end

        selected_items = items.select { |item| Constants::GROCERY_ITEMS_MAPPINGS.keys.include? item.to_sym }

        if selected_items != items
            puts "Please add available items"
            return false
        end

        return true
    end
end