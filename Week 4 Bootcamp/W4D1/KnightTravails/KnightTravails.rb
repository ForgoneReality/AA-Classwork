require 'set'
require_relative 'PolyTree.rb'

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
        return arr
    end

    def find_path(end_position)
        queue = Queue.new
        queue.push(PolyTreeNode.new(@start_position, nil))
        while(!queue.empty?)
            first = queue.pop
            if first.value == end_position #if found on current node
                return get_path(first)
            else #otherwise put children in the queue
                get_valid_next_positions(first.value).each do |child_position|
                    child = PolyTreeNode.new(child_position, first)
                    queue.push(child)
                end
            end
        end
        return nil
    end

    def get_valid_next_positions(pos)
        i,j = pos
        [[i+1, j+2], [i+1,j-2], [i-1,j+2], [i-1,j-2], [i+2,j+1], [i+2,j-1], [i-2,j+1], [i-2,j-1]].select {|ele| is_pos_valid?(ele) && is_pos_new?(ele)}
    end

    def is_pos_valid?(pos)
        @valid_positions.include?(pos)
    end

    def is_pos_new?(pos)
        !@seen_positions.include?(pos)
    end

    def get_path(node)
        if node.value == @start_position
            [node.value]
        else
            get_path(node.parent) << node.value 
        end
    end

end