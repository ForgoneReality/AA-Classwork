class MazeSolver
    #arr = new

    attr_reader :start, :ending
    attr_accessor :maze, :my_maze
    def initialize(filename="maze1.txt")
        setup_maze(filename) #assuming proper maze
        raise StandardError.new("Invalid Maze: Inproper start and ending") if !find_starting
    end

    def setup_maze(f)
        maze = []
        my_maze = []
        File.open(f).each_line do |line|
            x = line.chomp.split("")
            maze << x
            my_maze << x.dup
        end
        @maze = maze
        @my_maze = my_maze    
    end

    def find_starting
        #Assuming no weird circumstances where there's more than one starts or endings
        count = 0
        (0...@maze.length).each do |i|
            (0...@maze[0].length).each do |j|
                if maze[i][j] == 'S'
                    @start = [i, j]
                    count += 1
                    if count == 2
                        return true
                    end
                elsif maze[i][j] == 'E'
                    @ending = [i, j]
                    count += 1
                    if count == 2
                        return true
                    end
                end
            end
        end
        return false
    end

    def solve
        my_queue = Queue.new
        my_maze[start[0]][start[1]] = 0
        my_queue.push(start)
        while(!my_queue.empty?)
            top = my_queue.pop
            x = top[0]
            y = top[1]
            num = my_maze[x][y]

            if my_maze[x][y+1] == ' '
                my_queue.push([x, y+1])
                my_maze[x][y+1] = num + 1
            elsif my_maze[x][y+1] == 'E'
                solution_mapper(num)
                return
            end

            if my_maze[x][y-1] == ' '
                my_queue.push([x, y-1])
                my_maze[x][y-1] = num + 1
            elsif my_maze[x][y-1] == 'E'
                solution_mapper(num)
                return
            end

            if my_maze[x + 1] != nil
                if my_maze[x+1][y] == ' '
                    my_queue.push([x+1, y])
                    my_maze[x+1][y] = num + 1
                elsif my_maze[x+1][y] == 'E'
                    solution_mapper(num)
                    return
                end
            if my_maze[x - 1] != nil
                if my_maze[x-1][y] == ' '
                    my_queue.push([x-1, y])
                    my_maze[x-1][y] = num + 1
                end
                elsif my_maze[x-1][y] == 'E'
                    solution_mapper(num)
                    return
                end
            end
        end
        p "No Solution for this Maze found!"
    end

    def solution_mapper(num)
        x = ending[0]
        y = ending[1]
        
        while(num>0)
            if my_maze[x][y+1] == num
                maze[x][y+1] = 'X'
                num -= 1
                y += 1
                next
            end
            if my_maze[x][y-1] == num
                maze[x][y-1] = 'X'
                num -= 1
                y -= 1
                next
            end
            if my_maze[x + 1] != nil
                if my_maze[x+1][y] == num
                    maze[x+1][y] = 'X'
                    num -= 1
                    x += 1
                    next
                end
            end
            if my_maze[x - 1] != nil
                if my_maze[x-1][y] == num
                    maze[x-1][y] = 'X'
                    num -= 1
                    x -= 1
                    next
                end
            else
                p "wtf"
            end
        end
        print_maze
    end

    def print_maze(m = maze)
        m.each do |row|
            p row
        end
    end

end 

if __FILE__ == $PROGRAM_NAME     
    m = MazeSolver.new
    m.solve
end