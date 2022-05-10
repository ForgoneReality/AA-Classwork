require "byebug"

def consecutive_collapse(t)
    #debugger
    i = 0
    while i < t.length-1
        if(t[i] == t[i+1] + 1 || t[i] == t[i+1] - 1)
            t = t.reject.with_index {|ele, index| index == i || index == i+1}
            
            i = 0
        else
            i += 1
        end
    end
    return t
end

p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []