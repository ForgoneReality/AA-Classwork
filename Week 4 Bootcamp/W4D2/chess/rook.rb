require_relative "piece.rb"
require_relative "slideable.rb"

class Rook < Piece
    include Slideable

    def symbol #??????????
        return :rook
    end

    private
    def move_dirs
        return 0
    end
end