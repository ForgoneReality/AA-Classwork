require 'set'
require_relative "./player.rb"
require "./aiplayer.rb"

class Game
    attr_reader :dictionary, :players, :fragment
    attr_accessor :player_index
    def initialize(*players)
        @players = players
        @fragment = ""
        file = File.open("dictionary.txt")
        @dictionary = Hash.new { |h,k| h[k] = Set.new}

        file.readlines.each do |line|
            word = line.chomp
            @dictionary[""].add(word[0]) #bruh need this first
            (0...word.length-1).each do |i|
                @dictionary[word[0..i]].add(word[i+1])
            end
            @dictionary[word].add("*")
        end
        @player_index = 0
    end

    def current_player
        @players[@player_index]
    end

    def previous_player
        @players[@player_index - 1]
    end

    def next_player!
        @player_index += 1
        if @player_index == @players.length
            @player_index = 0
        end
    end
    
    def take_turn(player) 
        p "Current Word: " + @fragment
        player.is_a?(Player) ? g = player.guess : g = player.guess(@players.length, fragment, dictionary)
        while(g == "help")
            s = ""
            dictionary[@fragment].each {|char| s += char + " "}
            p "Possible choices: " + s
            player.is_a?(Player) ? g = player.guess : g = player.guess(@players.length, fragment, dictionary)
        end
        if valid_play?(g)
            @fragment += g
            if dictionary[@fragment].include?("*")
                return true
            else
                return false
            end
        else
            raise InputError.new("Invalid Input!")
        end
    rescue
        p "Invalid input or no such word exists"
        retry
    end

    def valid_play?(string)
        alphabet = "abcdefghijklmnopqrstuvwxyz"
        return (alphabet.include?(string) && string.length == 1 && dictionary[@fragment].include?(string))     
    end

    def play_round
        while true
            if(take_turn(current_player))
                current_player.losses += 1
                p "#{current_player.name} lost! #{fragment} is a full word!"
                break;
            else
                next_player!
            end
        end
    end

    def record(player)
        lose = "GHOST"
        lose[0...player.losses]
    end

    def run
        done = false
        i = 0
        while players.length > 1
            play_round
            lost = -1
            @players.each_with_index do |player, i|
                p "#{player.name} : " + record(player)
                if player.losses >= 5
                    done = true
                    p "#{player.name}, you lose!!!"
                    lost = i
                    @player_index = 0
                end
            end
            if lost != -1 #outside loop because it messes up printing
                @players.delete_at(lost)
            end
            @fragment = "" #reset fragment
        end
        p players[0].name + " wins the game!!"
    end
end

if __FILE__ == $PROGRAM_NAME
    p1 = Player.new("Player 1")
    p2 = AiPlayer.new("Player 2")
    g = Game.new(p1, p2)
    g.run
end