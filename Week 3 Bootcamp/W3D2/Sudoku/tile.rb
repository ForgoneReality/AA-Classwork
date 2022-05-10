class Tile
    attr_reader :val, :given

    def initialize(val, given)
        @val = val
        @given = given
    end

    def ==(other_tile)
        self.val == other_tile.val
    end

    def change_val(new_val)
        if !given
            @val = new_val
        end
    end

    def to_s
        @val.to_s
    end
end