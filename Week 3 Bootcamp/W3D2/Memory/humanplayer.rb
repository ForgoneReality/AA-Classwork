class HumanPlayer
    def initialize(length)
    end
    def prompt(prev)
        if prev
            puts "enter a position in format 'x y'"
        else 
            puts "enter a second position in format 'x y'"
        end
        gets.chomp.split.map {|ele| ele.to_i}
    end

    def do_extra(a, b)
        #do nothing
    end
end