require_relative "./item.rb"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description="")
        if Item.valid_date?(deadline)
            i = Item.new(title, deadline, description)
            @items << i
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        if index < 0
            return false
        else
            return index < @items.length
        end
    end

    def swap(index_1, index_2)
        if valid_index?(index_1) && valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def [](index)
        if valid_index?(index)
            @items[index]
        else
            nil
        end
    end

    def priority
        @items[0]
    end

    def print
        p @label.upcase.center(56)
        p "-"*56
        s = "Index | " + "Item".ljust(20) + "| " + "Deadline".ljust(14) + "| " + "Done?".ljust(10)
        p s
        p "-"*56
        @items.each_with_index do |item, i|
            if (item.done)
                p (i.to_s.ljust(6) + "| " + item.title.ljust(20) + "| " + item.deadline.ljust(14)) + "Yes!".ljust(12)
            else
                p (i.to_s.ljust(6) + "| " + item.title.ljust(20) + "| " + item.deadline.ljust(14)) + "No".ljust(12)
            end
        end

    end

    def print_full_item(index)
        if valid_index?(index)
            p @items[index].title
            p @items[index].deadline
            p @items[index].description
            if(@items[index].done)
                p "Done"
            else
                p "Not Done"
            end
        end
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount=1)
        if valid_index?(index)
            while(amount > 0 && index > 0)
                swap(index, index-1)
                amount -= 1
                index -= 1
            end
            return true
        end
        return false
    end

    def down(index, amount=1)
        if valid_index?(index)
            while(amount > 0 && index < size - 1)
                swap(index, index + 1)
                amount -= 1
                index += 1
            end
            return true
        end
        return false
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        if valid_index?(index)
            @items[index].toggle
        end
    end

    def remove_item(index)
        if(@items.delete_at(index) != nil)
            return true
        else
            return false
        end
    end

    def purge
        @items.reject! {|item| item.done}
    end

end
