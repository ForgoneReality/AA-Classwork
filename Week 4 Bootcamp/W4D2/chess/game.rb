require_relative "board.rb"
require_relative "display.rb"
require_relative "humanplayer.rb"
require_relative "computerplayer.rb"
require "byebug"

class Game
    attr_accessor :board, :display, :p1, :p2, :current_player

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @p1 = ComputerPlayer.new(:white, @display)
        @p2 = HumanPlayer.new(:black, @display)
        @current_player = @p1
    end

    def play
        while true #end when checkmated
            @current_player.make_move
            switch_turns

            if board.checkmate?(:white)
                p "Black has won!!"
                break
            end 
            if board.checkmate?(:black)
                p "White has won!!"
                break
            end
        end
    end

    def switch_turns
        @current_player == @p1 ? @current_player = @p2 : @current_player = @p1
    end

end

g = Game.new
g.play