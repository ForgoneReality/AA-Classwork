require_relative "board.rb"

class Game
    def initialize(file_name)
        @board = Board.new(file_name)
        @original_board = Board.new(file_name)
    end

    def show_original_board
        @original_board.render
    end

    def make_move
        p "Please enter the position you'd like to make a change in the format '1 2', or 'ori' for original board"
        
        inp = gets.chomp
        if inp == "ori"
            show_original_board
            return
        end
        inp = inp.split
        if inp.length != 2
            p "Please use proper position format"
            raise StandardError.new("Invalid Position")
        end
        numbers = "012345678"
        if numbers.include?(inp[0])
            inp[0] = inp[0].to_i
        else
            p "Please enter numbers 0-8 for position"
            raise StandardError.new("Invalid Position")
        end
        if numbers.include?(inp[1])
            inp[1] = inp[1].to_i
        else
            p "Please enter numbers 0-8 for position"
            raise StandardError.new("Invalid Position")
        end

        p "Please enter a number from 1-9 for the new value at entered position"
        val = gets.chomp

        sudoku_numbers = "123456789"
        if sudoku_numbers.include?(val)
            @board.update_title(inp, val.to_i)
        else
            p "Please enter a valid value!!"
            raise StandardError.new("Invalid Value")
        end
    rescue
        retry
    end

    def play
        while(!@board.solved?)
            @board.render
            make_move
        end

        p "You solved it!!"
        
    end
end

if __FILE__ == $PROGRAM_NAME
    g = Game.new("sudoku1_almost.txt")
    g.play
end