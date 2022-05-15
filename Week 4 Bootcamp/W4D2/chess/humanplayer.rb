require_relative "player.rb"
require_relative "board.rb"
require_relative "cursor.rb"

class HumanPlayer < Player
    def make_move
        begin
            p color
            display.render
            display.cursor.toggle_selected = false #shouldn't be needed, but just in case
            start_pos = display.cursor.get_input
            p color
            display.render
            while start_pos == nil
                start_pos = display.cursor.get_input
                p color
                display.render
            end
            if board[start_pos].empty? || board[start_pos].color != @color
                raise StandardError.new("Invalid starting position!")
            end
            end_pos = display.cursor.get_input
            p color
            display.render
            while end_pos == nil
                end_pos = display.cursor.get_input
                display.render
            end
            board.move_piece(start_pos, end_pos)
            p color
            display.render
        rescue StandardError => e
            p "Error occurred: #{e}"
            retry
        end
    end
end