require_relative "piece.rb"

class Pawn < Piece
    def symbol #??????????
        return :pawn
    end

    def moves
        return forward_dir + side_attacks
    end

    private

    def at_start_row?
        if color == :white
            return pos[0] == 6
        elsif color == :black
            return pos[0] == 1
        end
    end

    def forward_dir
        x,y = pos
        ans = []
        if color == :white
            if x>0
                if board[[x-1,y]].empty?
                    ans << [x-1, y]
                    if at_start_row?
                        if board[[x-2,y]].empty?
                            ans << [x-2, y]
                        end
                    end
                end
            end
        else
            if x<7
                if board[[x+1,y]].empty?
                    ans << [x+1, y]
                    if at_start_row?
                        if board[[x+2,y]].empty?
                            ans << [x+2, y]
                        end
                    end
                end
            end
        end
        return ans
    end
            

    def side_attacks
        x,y = pos
        ans = []
        if color == :white
            fd = -1
        else
            fd = 1
        end
        if y-1>=0
            if !board[[x+fd, y-1]].empty? && (board[[x+fd, y-1]].color != self.color)
                ans << [x+fd, y-1]
            end
        end
        if y+1<8
            if !board[[x+fd, y+1]].empty? && (board[[x+fd, y+1]].color != self.color)
                ans << [x+fd, y+1]
            end
        end
        return ans
    end

end