def matrix_addition_reloaded(*args)
    #first pre-process

    if(args.empty?)
        return nil 
    end

    l = args[0].length
    w = args[0][0].length

    (1...args.length).each do |i|
        if args[i].length != l || args[i][0].length != w
            return nil
        end
    end

    arr = Array.new(l) {Array.new(w, 0)}
    args.each do |matrix|
        (0...l).each do |i|
            (0...w).each do |j|
                arr[i][j] += matrix[i][j]
            end
        end
    end
    
    arr
end

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil