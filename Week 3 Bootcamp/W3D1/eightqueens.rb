require "byebug"

class EightQueens
    attr_accessor :size, :board, :columns, :stack

    def initialize(size = 8)
        @size = size
        @board = Array.new(size) {Array.new(size, " ")}
        @columns = Array.new(size, false)
        @stack = Array.new
    end

    def solve
        row = 0
        col = 0
        rewind_time = false
        while row < size
            # if row == 5
            #     debugger
            # end
            if rewind_time
                rewind_time = false
            else
                col = 0
            end
            while columns[col] == true
                col += 1
                if col >= size #failed to find any acceptable
                    rewind_time = true
                    break
                end
            end
            if(rewind_time || col>= size)
                row -= 1
                top = @stack.pop
                board[top[0]][top[1]] = " "
                @columns[top[1]] = false
                col = top[1] + 1
                rewind_time = true
                next
                #rewind
            end

            #found previously unused column in col q
            board[row][col] = "Q"
            if check_diagonals
                @stack.push([row, col])
                row += 1
                columns[col] = true
            else
                board[row][col] = " "
                col += 1
                rewind_time = true
            end
        end
    end

    def check_diagonals
        stack.each do |queen|
            x = queen[0] + 1
            y = queen[1] + 1
            while(x<size && y < size)
                if board[x][y] == 'Q'
                    return false
                end
                x += 1
                y += 1
            end
            x = queen[0] + 1
            y = queen[1] - 1
            while(x<size && y >= 0)
                if board[x][y] == 'Q'
                    return false
                end
                x += 1
                y -= 1
            end
            x = queen[0] - 1
            y = queen[1] + 1
            while(x>= 0 && y < size)
                if board[x][y] == 'Q'
                    return false
                end
                x -= 1
                y += 1
            end
            while(x>= 0 && y >= 0)
                if board[x][y] == 'Q'
                    return false
                end
                x -= 1
                y -= 1
            end
        end
        return true
    end

    def print_board
        board.each do |row|
            p row
        end
    end

end

if __FILE__ == $PROGRAM_NAME
    q = EightQueens.new
    q.solve
    q.print_board
end


