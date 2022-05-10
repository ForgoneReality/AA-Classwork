require_relative "./board.rb"
require_relative "./human_player.rb"

class Game

    def initialize(n, *player_marks)
        @players = []
        player_marks.each do |m|
            @players << HumanPlayer.new(m)
        end
        @board = Board.new(n)
        @curr = 0
    end

    def switch_turn
        @curr += 1
        if @curr == @players.length
            @curr = 0
        end

    end

    def play 
        while @board.empty_positions?
            @board.print
            temp = @players[@curr].get_position
            @board.place_mark(temp, @players[@curr].my_mark)
            if @board.win?(@players[@curr].my_mark)
                p "Victory! Player #{@curr + 1} has won!"
                return
            else
                switch_turn
            end
        end
        p "Draw... No more valid positions"
    end
end