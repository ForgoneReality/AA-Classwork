
class Player 
    attr_reader :name
    attr_accessor :losses

    def initialize(name)
        @name = name 
        @losses = 0
    end

    def guess
        p "#{name}, please enter a character in the alphabet, or type help for possiblities:"
        gets.chomp
    end

end