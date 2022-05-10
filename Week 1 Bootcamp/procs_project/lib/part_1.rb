def my_map(arr, &p)
    new_arr = []
    arr.each {|ele| new_arr << p.call(ele)}
    new_arr
end

def my_select(arr, &p)
    new_arr = []
    arr.each {|ele| new_arr << ele if p.call(ele)}
    new_arr
end

def my_count(arr, &p)
    new_arr = []
    count = 0
    arr.each {|ele| count+= 1 if p.call(ele)}
    return count
end

def my_any?(arr, &p)
    arr.each {|ele| return true if p.call(ele)}
    return false
end

def my_all?(arr, &p)
    arr.each do |ele|
        if !(p.call(ele))
            return false
        end
    end
    return true
end

def my_none?(arr, &p)
    arr.each {|ele| return false if p.call(ele)}
    return true
end