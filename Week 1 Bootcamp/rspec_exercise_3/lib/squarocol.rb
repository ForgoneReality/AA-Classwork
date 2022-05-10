def squarocol?(two_mat)
    return nil if two_mat.empty?

    two_mat.each do |mat|
        if mat.uniq.length == 1
            return true
        end
    end

    (0...two_mat.length).each do |j|
        init = two_mat[0][j]
        if (1...two_mat.length).all? {|i| two_mat[i][j] == init}
            return true
        end
    end
    return false
end

p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false