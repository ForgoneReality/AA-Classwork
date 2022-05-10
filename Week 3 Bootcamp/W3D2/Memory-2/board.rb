
require_relative "./card.rb"

class Board
    attr_reader :length, :grid
    ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    def initialize(length, bombs)

        #length > 7 causes issues
        @length = length
        @cards = []
        (0...(@length**2)/2).each do |i| #!
            @cards << Card.new(ALPHABET[i])
            @cards << Card.new(ALPHABET[i])
        end
        bombs.times do
            @cards << Card.new("*")
        @grid = Array.new(length) {Array.new(length)}
    end

    def populate
        @cards.shuffle!
        (0...@length).each do |i|
            (0...@length).each do |j|
                @grid[i][j] = @cards[i*@length + j]
            end
        end
    end

    def render
        p "___________________"
        #system("clear")
        @grid.each do |row|
            new_str = ""
            row.each do |card|
                new_str += card.info + " "
            end
            puts new_str
        end
    end

    def won?
        @grid.all? do |row|
            row.all? do |card|
                !(card.face_down)
            end
        end
    end

    def reveal(row, col)
        if @grid[row][col].face_down
            @grid[row][col].reveal
        end
        return @grid[row][col].info
    end
end





    





        
        
