def element_count(arr)
    my_hash = Hash.new(0)
    arr.each {|ele| my_hash[ele] += 1}
    my_hash
end

def char_replace!(str, h)
    str.each_char.with_index do |char, i|
        str[i] = h[char] if h.include?(char)
    end
end

def product_inject(arr)
    arr.inject {|acc, ele| acc = acc * ele}
end