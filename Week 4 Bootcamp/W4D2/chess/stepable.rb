module Stepable
    def moves

        x,y = @pos
        ans = []
        move_diffs.each do |bob|
            i, j = bob
            if (x+i>=0 && x+i<8 && y+j >= 0 && y+j <8)
                if board[[x+i, y+j]].empty? || (board[[x+i, y+j]].color != self.color)
                    ans << [x+i, y+j]
                end
            end
        end
        return ans
    end

    def move_diffs
        p "Should have been overloaded"
    end
end