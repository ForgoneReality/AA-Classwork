require_relative "piece.rb"
require_relative "stepable.rb"

class Knight < Piece
    include Stepable

    def symbol #??????????
        return :knight
    end

    private
    def move_diffs
        return [[-2,-1], [-2, 1], [2, -1], [2,1], [1, -2], [1, 2], [-1,-2], [-1,2]]
    end
end