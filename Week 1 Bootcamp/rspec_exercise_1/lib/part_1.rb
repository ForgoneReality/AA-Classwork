def average(num_1, num_2)
    return (num_1+ num_2)/2.0
end

def average_array(arr)
    (0.0 + arr.inject {|acc, ele| acc += ele} )/ arr.length
end

def repeat(word, n)
    str = ""
    return str if n<=0

    n.times { str+= word }
    return str
end

def yell(word)
    return word.upcase! + "!"
end

def alternating_case(sentence)
    a = sentence.split(" ")
    caps = true
    a.each_with_index do |word, i| #didnt use word but whatever...
        if caps
            a[i].upcase!
            caps = false
        else
            a[i].downcase!
            caps = true
        end
    end
    return a.join(" ")
end