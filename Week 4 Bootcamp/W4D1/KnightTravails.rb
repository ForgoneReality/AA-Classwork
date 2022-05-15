require 'set'

class KnightPathFinder
    attr_reader :valid_positions
    def initialize(start_position)
        @start_position = start_position
        @valid_positions = valid_pos
        @seen_positions = Set.new
        @seen_positions.add(start_position)
    end

    def valid_pos
        arr = [] 
        (0...8).each do |num1|
            (0...8).each do |num2|
                arr << [num1, num2]
            end
        end
        return arr.uniq
    end

    
    

end

k = KnightPathFinder.new([0,0])
p k.valid_positions