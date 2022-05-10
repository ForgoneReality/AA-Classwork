class Card
    attr_reader :val, :face_down

    def initialize(val)
        @val = val
        @face_down = true
    end

    def info
        if @face_down
            " "
        else
            @val
        end
    end

    def hide
        @face_down = true
    end

    def reveal
        @face_down = false
    end

    def to_s
        @val = @val.to_s
    end

    def ==(other_card)
        @val == other_card.val
    end
    
end



