def zip(*arrs)
    l = arrs.length
    w = arrs[0].length
    new_arr = Array.new(w) { Array.new(l) }
    (0...w).each do |i|
        (0...l).each do |j|
            new_arr[i][j] = arrs[j][i]
        end
    end
    return new_arr
end

def prizz_proc(arr, p1, p2)
    new_arr = []
    arr.each do |ele|
        count = 0
        count += 1 if p1.call(ele)
        count += 1 if p2.call(ele)
        if count == 1
            new_arr << ele
        end
    end
    return new_arr
end

def zany_zip(*arrs)
    l = arrs.length
    w = arrs.map {|arr| arr.length}

    new_arr = Array.new(w.max) { Array.new(l) }
    (0...l).each do |i|
        (0...w[i]).each do |j|
            new_arr[j][i] = arrs[i][j]
        end
    end
    
    return new_arr
end

def maximum (arr, &p)
    if arr.empty?
        return nil
    end

    max_index = 0
    max = p.call(arr[0])

    (1...arr.length).each do |i|
        if p.call(arr[i]) >= max #assuming this call doesnt change when called twice
            max_index = i
            max = p.call(arr[i])
        end
    end

    return arr[max_index]
end

def my_group_by(arr, &p)
    h = Hash.new { |k,v| k[v] = []} #!!!!!!!!!!!!!!!!!!!!
    arr.each do |ele|
        h[p.call(ele)] << (ele)
    end
    h
end

def max_tie_breaker(arr, p1, &p2)
    if arr.empty?
        return nil
    end

    maxx = arr[0]

    (1...arr.length).each do |i| 
        if p2.call(arr[i]) > p2.call(maxx)
            maxx = arr[i]
        elsif p2.call(arr[i]) == p2.call(maxx)
            if p1.call(arr[i]) > p1.call(maxx)
                maxx = arr[i]
            elsif p1.call(arr[i]) == p1.call(maxx)
                #nothing
            end
        end
    end
    return maxx
end

def silly_syllables(sentence)
    words = sentence.split(" ")
    vowels = "aieou" #assuming loewrcase
    words = words.map do |word|
        arr = [] #unnecessary but my brain fried super duper so ya
        
        word.each_char.with_index {|char, i| arr << i if vowels.include?(char)}
        arr.length >= 2 ? word[arr[0].. arr[-1]] : word
    end
    words.join(" ")
end


