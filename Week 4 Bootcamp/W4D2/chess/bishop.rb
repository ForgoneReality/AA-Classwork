require_relative "piece.rb"
require_relative "slideable.rb"

class Bishop < Piece
    include Slideable
    def symbol #??????????
        return :bishop
    end

    private
    def move_dirs
        return 1
    end
end