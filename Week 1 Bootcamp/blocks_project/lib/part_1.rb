def select_even_nums(arr)
    arr.select {|nums| nums%2 == 0}
end

def reject_puppies(arr)
    arr.reject {|hashy| hashy["age"] <= 2}
end

def count_positive_subarrays(arr)
    arr.count {|subarry| subarry.sum > 0}
end

def aba_translate(word)
    #assuming lower-case
    a = word.split("")
    a.each_with_index do |char, i|
        if "aeiou".include?(char)
            a[i] = char + "b" + char
        end
    end
    a.join("")
end

def aba_array(array)
    array.map {|ele| aba_translate(ele)}
end
