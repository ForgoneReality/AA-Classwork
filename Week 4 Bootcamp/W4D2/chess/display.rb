require 'colorize'
require_relative "board.rb"
require_relative "cursor.rb"

class Display
    attr_accessor :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([7,0], board)
    end

    def render
        x = 0
        puts ""
        board.rows.each_with_index do |row, i|
            s = ""
            row.each_with_index do |ele, j|
                if x%2 == 0
                    if i == cursor.cursor_pos[0] && j == cursor.cursor_pos[1] 
                        if ele.to_s == " "
                            a = "_ "
                        else 
                            a = ele.to_s + " "
                        end
                        if cursor.toggle_selected
                            s += a.colorize(:color => :light_magenta, :background => :light_green)
                        else
                            s += a.colorize(:color => :red, :background => :light_green)
                        end
                    else
                        a = ele.to_s + " "
                        s += a.colorize(:color => ele.color, :background => :light_green)
                    end
                else
                    if i == cursor.cursor_pos[0] && j == cursor.cursor_pos[1] 
                        if ele.to_s == " "
                            a = "_ "
                        else 
                            a = ele.to_s + " "
                        end
                        if cursor.toggle_selected
                            s += a.colorize(:color => :light_magenta, :background => :light_cyan)
                        else
                            s += a.colorize(:color => :red, :background => :light_cyan)
                        end
                    else
                        a = ele.to_s + " "
                        s += a.colorize(:color => ele.color, :background => :light_cyan)
                    end
                end
                x += 1
            end
            x += 1
            puts s
        end
    end
end

# if __FILE__ == $PROGRAM_NAME
#     b = Board.new
#     d = Display.new(b)
#     # b.move_piece([6,5],[5,5])
#     # b.move_piece([6,6],[4,6])
#     # b.move_piece([1,4],[3,4])
    
#     # p b.checkmate?(:white)

#     # #------------
#     # p b[[0,3]].valid_moves
#     # p b[[7,4]].valid_moves

#     # # #------------

#     # b.move_piece([0,3],[4,7])
#     # p b.checkmate?(:white)


#     # ATTEMPT 1
#     # p "now?"
#     # b.move_piece([4,7],[5,6])
#     # p b.checkmate?(:white)

#     # b.move_piece([5,6],[6,5])
#     # p b.checkmate?(:white)
#     ##

#     # p "what about this..."
#     # b.move_piece([4,7], [5,7])
#     # b.move_piece([1,5], [3,5])
#     # b.move_piece([0,5], [1,4])
#     # b.move_piece([1,4], [4,7])
#     # p b.checkmate?(:white)
#     # b.move_piece([7,4], [6,5])
#     # b.move_piece([3,5], [4,5])
#     # p b.checkmate?(:white)
   

#     d.render
# end