class Player
    def get_move
        p "enter a position with coordinates separated with a space like `4 7`'"
        inp = gets
        inp = inp.chomp
        arr = []
        arr << inp[0].to_i
        arr << inp[2].to_i
    end

    
end
