# Define your methods here.
def string_map!(s, &p)
    s.each_char.with_index do |c, i|
        s[i] = p.call(c)
    end
    #relies on the block only bringing back 1 character

end

def three?(arr, &p)
    count = arr.count {|ele| p.call(ele)}
    return count == 3
end

def nand_select(arr, p1, p2)
    new_arr = arr.reject {|ele| p1.call(ele) && p2.call(ele)}
end

def hash_of_array_sum(h)
    h.values.flatten.sum
end

def abbreviate(sentence)
    vowels = "aeiouAEIOU"
    words = sentence.split(" ")
    b = words.each_with_index do |word, i|
        if word.length > 4
            a = word.split("")
            a.reject! {|char| vowels.include?(char)}
            words[i] = a.join("")
        end
    end
    b.join(" ")
end

def hash_selector(h, *args)
    return h if args.empty?

    new_h = {}

    h.each do |k, v|
        if args.include?(k)
            new_h[k] = v
        end
    end
    new_h
end

        