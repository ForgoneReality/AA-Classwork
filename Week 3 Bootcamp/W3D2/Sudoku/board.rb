require_relative "tile.rb"
require "set"

class Board
    attr_reader :grid

    def self.from_file(file_name)
        arr = File.readlines(file_name)
        ans = []
        arr.each do |line|
            temp = []
            l = line.chomp
            l.each_char do |char|
                char = char.to_i
                if char == 0
                    temp << Tile.new(char, false)
                else
                    temp << Tile.new(char, true)
                end
            end
            ans << temp
        end
        ans
    end

    def initialize(file_name)
        @grid = Board.from_file(file_name)
    end

    def render
        @grid.each do |row|
            s = ""
            row.each do |tile|
                s += tile.to_s + " "
            end
            puts s
        end
    end

    def update_title(pos, val)
        x, y = pos
        @grid[x][y].change_val(val)
    end

    def solved_rows?
        (0...9).each do |i|
            hash = {1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1, 7 => 1, 8 => 1, 9=>1}
            (0...9).each do |j|
                if hash[grid[i][j].val] != 1
                    return false
                else
                    hash[grid[i][j].val] -= 1
                end
            end
        end
        return true
    end

    def solved_columns?
        (0...9).each do |j|
            hash = {1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1, 7 => 1, 8 => 1, 9=>1}
            (0...9).each do |i|
                if !hash.include?(grid[i][j].val) || hash[grid[i][j].val] != 1
                    return false
                else
                    hash[grid[i][j].val] -= 1
                end
            end
        end
        return true
    end

    def solved_boxes?
        #box_left_corners = [[0,0], [3,0], [6,0], [3,0], [3,3], [3,6], [6,0], [6,3],[6,6]
        (0..2).each do |x|
            (0..2).each do |y|
                xx = 3 * x
                yy = 3 * y
                hash = {1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1, 7 => 1, 8 => 1, 9=>1}
                (0..2).each do |i|
                    (0..2).each do |j|
                        if !hash.include?(grid[xx+i][yy+j].val) || hash[grid[xx+i][yy+j].val] != 1
                            return false
                        else
                            hash[grid[xx+i][yy+j].val] -= 1
                        end
                    end
                end
            end
        end
        return true
    end

                

    def solved?
        return solved_rows? && solved_columns? && solved_boxes?
    end  
end