class Player
    attr_accessor :color, :display, :board
    def initialize(color, display)
        @color = color
        @display = display
        @board = display.board
    end
end