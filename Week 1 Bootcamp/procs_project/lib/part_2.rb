def reverser(string, &p)
    p.call(string.reverse)
end

def word_changer(sentence, &p)
    a = sentence.split(" ")
    a = a.map {|word| p.call(word)}
    a.join(" ")
end

def greater_proc_value(num, p1, p2)
    p1.call(num) > p2.call(num) ? p1.call(num) : p2.call(num)
end

def and_selector(arr, p1, p2)
    arr.select { |num| p1.call(num) && p2.call(num)}
end

def alternating_mapper(arr, p1, p2)
    arr.map.with_index {|ele, i| i%2 == 0 ? p1.call(ele) : p2.call(ele)}
end
