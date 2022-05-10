class Board
    attr_reader :grid, :size

    def initialize(n)
        arr = Array.new(n) {Array.new(n, "_")}
        @size = n
        @grid = arr
    end

    def valid?(position)
        position[0] >= 0 && position[0] < @size && position[1] >= 0 && position[1] < @size
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
        (0...@size).each do |j|
            return true if (0...@size).all? {|i| @grid[i][j] == mark}
        end
        return false
    end

    def win_diagonal?(mark)
        if (0...@size).all? {|i| @grid[i][i] == mark}
            return true
        elsif (0...@size).all? {|j| @grid[@size-1 - j][j] == mark}
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