require_relative "board.rb"
require_relative "card.rb"
require_relative "humanplayer.rb"
require_relative "computerplayer.rb"

class Game
    attr_reader :board

    def initialize(length, player)
        @board = Board.new(length)
        @previous_guess = []
        @player = player
    end

    def play
        over = false
        @board.populate
        while !over
            
            @board.render
            if @previous_guess == []
                input = @player.prompt(true)
            else
                input = @player.prompt(false)
            end 
            p "INPUT:"
            p input
            make_guess(input)
            @player.do_extra(@board.grid[input[0]][input[1]].val, input)

            if @board.won?
                over = true
            end
        end
        p "Game Over! You Won!"
    end

    def make_guess(our_guess)
        row, col = our_guess
        if row < 0 || col < 0 || row >= @board.length || col >= @board.length || @board.grid[row][col].info != " "
            puts "Invalid Guess! Please choose valid face-down position"
            return
        elsif @previous_guess == []
            @board.reveal(row, col)
            @previous_guess = [row, col]
            @board.render
        else
            #debugger
            
            if board.reveal(row, col) != board.grid[@previous_guess[0]][@previous_guess[1]].val
                p "Not a Match!"
                board.render
                sleep(2)
                board.grid[row][col].hide
                board.grid[@previous_guess[0]][@previous_guess[1]].hide
            else
                board.render
                p "Found Match!"
                sleep(0.5)
            end
            @previous_guess = []
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    c = ComputerPlayer.new(6)
    g = Game.new(6,c)
    g.play
end