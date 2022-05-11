require_relative "piece.rb"
require_relative "stepable.rb"

class King < Piece
    include Stepable

    def symbol #??????????
        return :king
    end

    private
    def move_diffs
        return [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]]
    end
end