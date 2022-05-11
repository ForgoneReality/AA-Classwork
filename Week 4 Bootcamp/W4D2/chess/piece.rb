class Piece
    attr_accessor :pos
    attr_reader :board, :color

    def initialize(color, board, pos) #need color
        @color = color
        @board = board
        @pos = pos
    end

    def to_s 
        if symbol == :queen
            return "q"
        elsif symbol == :rook
            return "r"
        elsif symbol == :bishop
            return "b"
        elsif symbol == :knight
            return "k"
        elsif symbol == :king
            return "*"
        elsif symbol == :pawn
            return "."
        else
            return " "
        end
    end
    
    def empty?
        return false
    end

    def valid_moves
        #for check? to do later in part 2
    end
    
    def symbol
        raise "should have overloaded symbol" #?????
    end

    def move_into_check?(end_pos)
        x,y = self.pos
        board[[x,y]] = board.nullpi
        a,b = end_pos
        temp = board[[a,b]]
        board[[a,b]] = self

        if symbol == :king
            ans = board.in_check?(color, [a,b], end_pos)
        else
            ans = board.in_check?(color, [a,b])
        end
        board[[a,b]] = temp
        board[[x,y]] = self
        return ans
    end

    def valid_moves
        self.moves.select do |potential_move|
            !move_into_check?(potential_move)
        end
    end
end