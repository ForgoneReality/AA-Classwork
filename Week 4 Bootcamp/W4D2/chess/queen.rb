require_relative "piece.rb"
require_relative "slideable.rb"

class Queen < Piece
    include Slideable

    def symbol #??????????
        return :queen
    end

    private
    def move_dirs
        return 2
    end
end