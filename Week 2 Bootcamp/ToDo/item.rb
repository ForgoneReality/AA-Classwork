class Item
    attr_reader :deadline, :done
    attr_accessor :title, :description

    def self.valid_date?(date_string)
        nums = "0123456789"
        (nums.include?(date_string[0]) && nums.include?(date_string[1]) && nums.include?(date_string[2]) && nums.include?(date_string[3]) && date_string[4] == "-" && nums.include?(date_string[5]) && nums.include?(date_string[6]) && date_string[7] == "-" && nums.include?(date_string[8]) && nums.include?(date_string[9]) && date_string[5..6].to_i >= 1 && date_string[5..6].to_i <= 12 && date_string[8..9].to_i >= 1 && date_string[8..9].to_i <= 31)
        
    end

    def initialize(title, deadline, description)
        @title = title
        if !(Item.valid_date?(deadline))
            raise ArgumentError.new("Invalid date entered")
        end
        @deadline = deadline

        @description = description
        @done = false
    end

    def deadline=(deadline)
        if Item.valid_date?(deadline)
            @deadline = deadline
        else
            raise ArgumentError.new("Invalid date entered")
        end
    end

    def toggle
        @done = !@done
    end


end
