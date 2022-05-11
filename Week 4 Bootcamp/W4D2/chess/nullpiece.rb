require "singleton"

class NullPiece < Piece
    include Singleton

    def initialize #need color
    end

    def color
        return nil
    end
    
    def symbol
        return :empty
    end
    
    def empty?
        return true
    end
end