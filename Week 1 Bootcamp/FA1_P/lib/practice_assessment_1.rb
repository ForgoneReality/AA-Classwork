# Define your methods here. 
def first_letter_vowel_count(sentence)
    vowels = "aeiouAEIOU"
    a = sentence.split(" ")
    count = 0
    a.each do |word|
        if vowels.include?(word[0])
            count += 1
        end
    end
    count
end

def count_true(arr, p)
    arr.count {|ele| p.call(ele)}
end

def procformation(arr, p1, p2, p3)
    new_arr = arr.map do |ele|
        p1.call(ele) ? p2.call(ele) : p3.call(ele)
    end
    new_arr
end

def array_of_array_sum(arr)
    arr.flatten.inject { |acc, ele| acc + ele}
end

def selective_reverse(sentence)
    vowels = "aeiouAEIOU"
    a = sentence.split(" ")
    a.each_with_index do |word, i|
        if !(vowels.include?(word[0])) && !(vowels.include?(word[-1]))
            a[i] = word.reverse
        end
    end
    a.join(" ")
end

def hash_missing_keys(h, *args)
    return args if args.empty?

    arr = args.reject {|ele| h.include?(ele)}
    arr
end

