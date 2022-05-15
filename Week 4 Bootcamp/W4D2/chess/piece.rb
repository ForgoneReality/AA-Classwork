class Piece
    attr_accessor :pos, :moved
    attr_reader :board, :color

    def initialize(color, board, pos) #need color
        @color = color
        @board = board
        @pos = pos
        @moved = false
    end

    def to_s 
        if symbol == :rook
            return self.color === :white ? "♖" : "♜" 
        elsif symbol == :queen
            return self.color === :white ? "♕" : "♛" 
        elsif symbol == :bishop
            return self.color === :white ? "♗" : "♝" 
        elsif symbol == :knight
            return self.color === :white ? "♘" : "♞" 
        elsif symbol == :king
            return self.color === :white ? "♔" : "♚" 
        elsif symbol == :pawn
            return self.color === :white ? "♙" : "♟" 
        else
            return " "
        end
    end
    
    def empty?
        return false
    end

    def valid_moves
        x = self.moves.select do |potential_move|
            !move_into_check?(potential_move)
        end
        return x
    end

    def attack_moves
        return self.moves
    end
    
    def symbol
        raise "should have overloaded symbol" #?????
    end

    def move_into_check?(end_pos)
        x,y = self.pos 
        board[[x,y]] = board.nullpi
        a,b = end_pos
        temp = board[[a,b]]
        #did not delete... shouldn't be problem because move_into_check has depth 1
        board[[a,b]] = self
        self.pos = [a,b]

        ans = board.in_check?(color, [a,b])
        board[[a,b]] = temp
        board[[x,y]] = self
        self.pos = [x,y]

        return ans
    end

end