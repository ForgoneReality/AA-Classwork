require "byebug"

class ComputerPlayer

    attr_reader :counter
    attr_reader :known_cards, :unseen, :first_guess, :first_guess_val

    def initialize(length)
        @length = length
        # @memory = Array.new(length) {Array.new(length, "?")}
        @unseen = Array.new
        (0...@length).each do |i|
            (0...@length).each do |j|
                @unseen << [i, j]
            end
        end
        @known_cards = Hash.new {|h,k| h[k] = Array.new}
        @to_do = []
        @first_guess = []
        @first_guess_val = "0"
        @counter = 0
    end

    def prompt(prev)
        if @to_do != []
            return @to_do.pop
        end
    
        @unseen.shuffle!
        
        return @unseen.pop
    end

    def do_extra(val, input)
        #debugger
        if counter <= 0 
            @known_cards[val] << input
            if @known_cards[val].length == 2 && !(first_guess_val == val && first_guess != [])
                #receive_match(@known_cards[val][0],@known_cards[k][1])
                if @first_guess == [] #first_guess
                    @to_do << @known_cards[val][0].dup
                    counter = 1
                    @known_cards[val] = []
                else #second_guess
                    @to_do = @known_cards[val].dup
                    counter = 2
                    @known_cards[val] = []
                end
            end #!!!!! return?
        else
            counter -= 1
        end

        if @first_guess == []
            @first_guess = input
            @first_guess_val = val
        else
            if(val == @first_guess_val)
                @known_cards[val] = []
                #
            end
            @first_guess = []
            @first_guess_val = -1
        end
    end
end

