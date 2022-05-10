def squaragonal?(two_mat)
    #can assume 2-D
    if two_mat.empty?
        return false
    end

    l = two_mat.length
    d1 = two_mat[0][0]
    d2 = two_mat[0][l-1]

    return (1...l).all? {|i| two_mat[i][i] == d1} || (1...l).all? {|i| two_mat[i][l-1-i] == d2}
end

p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false