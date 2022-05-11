require_relative "board.rb"
require_relative "display.rb"
require_relative "humanplayer.rb"

class Game
    attr_accessor :board, :display, :p1, :p2, :current_player

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @p1 = HumanPlayer.new(:white, @display)
        @p2 = HumanPlayer.new(:black, @display)
        @current_player = @p1
    end

    def play
        while true #end when checkmated
            @current_player.make_move(board)
            @current_player == @p1 ? @current_player = @p2 : @current_player = @p1
        end
    end
end

g = Game.new
g.play