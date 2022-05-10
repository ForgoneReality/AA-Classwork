require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game

    def initialize(n, h)
        @players = []
        h.each do |m, cpu|
            if !cpu
                @players << HumanPlayer.new(m)
            else
                @players << ComputerPlayer.new(m)
            end
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
            temp = @players[@curr].get_position(@board.legal_positions)
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