class Board

    def initialize
        arr = Array.new(3) {Array.new(3, "_")}
        @grid = arr
    end

    def valid?(position)
        position[0] >= 0 && position[0] < 3 && position[1] >= 0 && position[1] < 3
    end

    def empty?(position)
        @grid[position[0]][position[1]] == "_"
    end

    def place_mark(position, mark)
        if(valid?(position) && empty?(position))
            @grid[position[0]][position[1]] = mark
        else
            raise ArgumentError.new("Invalid position")
        end
    end

    def print()
        @grid.each {|arr| p arr}
    end

    def win_row?(mark)
        @grid.any? do |row|
            return true if row.all? {|ele| ele == mark}
        end
        return false
    end

    def win_col?(mark)
        (0..2).each do |j|
            return true if (0..2).all? {|i| @grid[i][j] == mark}
        end
        return false
    end

    def win_diagonal?(mark)
        if @grid[0][0] == mark && @grid[1][1] == mark && @grid[2][2] == mark
            return true
        elsif @grid[2][0] == mark && @grid[1][1] == mark && @grid[0][2] == mark
            return true
        else
            return false
        end
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? do |arr|
            arr.any? {|ele| ele == "_"}
        end
    end

end