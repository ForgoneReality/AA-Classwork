def my_min(list)
    list.each do |ele|
        is_smallest = true
        list.each do |e|
            if ele > e
                is_smallest = false
            end
        end
        return ele if is_smallest
    end
end

#time complexity is O(n^2)

def my_min_v2(arr)
    min = nil
    arr.each do |ele|
        if min == nil || ele < min
            min = ele
        end
    end
    p min
end

#time complexity is O(n)

def largest_contiguous_subsum_v1(arr)
    largest_sum = nil
    arr.each_with_index do |ele, i|
        (i...arr.length).to_a.each do |j|
            if largest_sum == nil ||  arr[i..j].sum > largest_sum 
                largest_sum = arr[i..j].sum 
            end
        end
    end
    largest_sum
end

def largest_contiguous_subsum(arr) 
    largest = -10000000000
    current_sum = -100000000
    arr.each do |ele|
        if current_sum < 0 #case where running sum is negative
            current_sum = ele
        else
            current_sum += ele
        end
        
        if current_sum > largest
            largest = current_sum
        end
    end
    return nil if largest == -10000000000
    return largest
end