def my_reject(arr, &p)
    arr.select{|ele| !p.call(ele)}
end

def my_one?(arr, &p)
    yup = false
    arr.each do |ele|
        if p.call(ele)
            if yup
                return false
            else
                yup = true
            end
        end
    end
    return yup
end

def hash_select(my_hash, &p)
    new_hash = {}
    my_hash.each { |k, v| new_hash[k] = v if p.call(k, v)}
    new_hash
end

def xor_select(arr, l, r)
    new_arr = arr.select do |ele| 
        hi = 0
        hi += 1 if l.call(ele)
        hi += 1 if r.call(ele)
        hi == 1
    end
    new_arr
end

def proc_count(val, arr)
    count = 0 
    arr.each do |ele|
        count += 1 if ele.call(val)
    end
    count
end
    