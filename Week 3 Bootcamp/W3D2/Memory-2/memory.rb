require_relative "humanplayer.rb"
require_relative "computerplayer.rb"
require_relative "game.rb"

class Memory
    def initialize
        puts "'player or computer?"
        if gets.chomp.downcase == "computer"
            @player = HumanPlayer.new(4)
        else
            @player = ComputerPlayer.new(4)
        end

        #game difficulty determines board size, number of bombs, and turns allowed
        puts "Please enter a difficult: easy, normal, or hard"
        inp = gets.chomp.downcase
        if inp == "easy"
            @player.length = 4
            p "Game Started! Easy Game has 0 Bombs, and infinite Allowed Turns"
            @game = Game.new(4, 0, 1000, @player)
        elsif inp == "normal"
            @player.length = 5
            p "Game Started! Normal Game has 1 Bomb, and 60 Max Allowed Turns"
            @game = Game.new(5, 0, 50, @player)
        elsif inp == "hard"
            @player.length = 6
            p "Game Started! Hard Game has 4 Bombs, and 50 Max Allowed Turns"
            @game = Game.new(6, 0, 60, @player)
        end
        #player?
                
    end




if __FILE__ == $PROGRAM_NAME
    c = ComputerPlayer.new(4)
    g = Game.new(4, c)
    g.play
end


