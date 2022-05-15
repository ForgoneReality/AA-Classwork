def two_sum?(arr, target)
    best_two_sum?(arr, target)
end

def bad_two_sum?(arr, target)
    arr.each_with_index do |ele, idx|
        arr.each_with_index do |e, j|
            if idx < j && ele + e == target
                return true
            end
        end
    end
    return false
end
#O(n^2)

def okay_two_sum?(arr, target)
    a = arr.sort
    i = 0
    j = arr.length - 1
    while (i<j)
        if a[i] + a[j] == target
            return true
        elsif a[i] + a[j] > target
            j -= 1
        else
            i += 1
        end
    end
    return false
end
#O(n logn)


def best_two_sum?(arr, target)
    hash = Hash.new(nil)
    arr.each do |ele| 
        num = target - ele
        if hash[num] != nil
            return true
        end
        hash[ele] = 1
    end
    return false
end

#O(n)

# arr = [0, 1, 5, 7]
# p two_sum?(arr, 6) # => should be true
# p two_sum?(arr, 10) # => should be false
# p two_sum?([9,20,1,13,2,5,-7, 5], 13)
