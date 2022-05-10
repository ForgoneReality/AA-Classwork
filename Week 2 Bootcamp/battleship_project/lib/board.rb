class Board
    attr_reader :size

  def initialize(n)
    @grid = Array.new(n) {Array.new(n, :N)}
    @size = n*n
  end

  def [](arr)
    @grid[arr[0]][arr[1]]
  end

  def []=(arr, value)
    @grid[arr[0]][arr[1]] = value
  end

  def num_ships
    @grid.flatten.count {|ele| ele == :S}
  end

    def attack(arr)
        if self[arr] == :S
            self[arr] = :H
            p "you sunk my battleship"
            return true
        else
            self[arr] = :X
            return false
        end
    end

    def place_random_ships
        arr = (0...@size).to_a.sample(@size/4)
        l = @grid.length
        arr.each {|i| @grid[i%l][i/l] = :S}
    end

    def hidden_ships_grid
        arr = Array.new(@grid.length) {Array.new(@grid.length)}
        @grid.each_with_index do |a, i|
            a.each_with_index do |ele, j|
                if ele == :S
                    arr[i][j] = :N 
                else
                    arr[i][j] = ele
                end
            
            end
        end
        arr
    end

    def self.print_grid(arr)
        arr.each do |a|
            puts a.join(" ")
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
