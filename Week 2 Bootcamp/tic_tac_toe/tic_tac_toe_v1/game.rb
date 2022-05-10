require_relative "./board.rb"
require_relative "./human_player.rb"

class Game

    def initialize(p1m, p2m)
        @player1 = HumanPlayer.new(p1m)
        @player2 = HumanPlayer.new(p2m)
        @board = Board.new
        @curr_1 = true
    end

    def switch_turn
        @curr_1 = !@curr_1
    end

    def play 
        while @board.empty_positions?
            @board.print
            if(@curr_1)
                temp = @player1.get_position
                @board.place_mark(temp, @player1.my_mark)
                if @board.win?(@player1.my_mark)
                    p "Victory! Player 1 has won!"
                    return
                else
                    @curr_1 = false
                end
            else 
                temp = @player2.get_position
                @board.place_mark(temp, @player2.my_mark)
                if @board.win?(@player2.my_mark)
                    p "Victory! Player 2 has won!"
                    return
                else
                    @curr_1 = true
                end
            end
        end
        p "Draw... No more valid positions"
    end
end