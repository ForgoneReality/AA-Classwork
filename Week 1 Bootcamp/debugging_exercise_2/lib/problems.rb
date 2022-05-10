# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(num)
    p_factors = []
    get_me_out = false

    while(num>1 && !get_me_out)
        (2..num).each do |factor|
            if factor * factor > num #NOTICE THAT IT CANT BE GREATER THAN THE SQRT OF NUM AND STILL NOT FOUND ONE! unless prime
                get_me_out = true
                p_factors << num if(num > 1)
                break
            end
            if num % factor == 0
                num = num / factor
                p_factors << factor
                break
            end
        end
    end

    return p_factors.max
end


def unique_chars?(string)
    h = Hash.new(false)
    string.each_char do |char|
        if h[char] == false
            h[char] = true
        else
            return false
        end
    end
    return true
end


def dupe_indices(arr)
    h = Hash.new {|v, k| v[k] = []}
    arr.each_with_index do |ele, i|
        h[ele] << i
    end
    h.each_key do |k|
        if (h[k].length == 1)
            h.delete(k)
        end
    end
    return h
end

def ana_array(array1, array2)
    #assuming non-empty array
    
    return false if array1.length != array2.length

    a = array1.sort!
    b = array2.sort!

    return a == b
end
    