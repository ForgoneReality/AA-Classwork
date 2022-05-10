def partition(arr, divider)
    left = []
    right = []
    arr.each do |ele|
        if ele < divider
            left << ele
        else
            right << ele
        end
    end
    ans = []
    ans << left
    ans << right
end

def merge(hash_1, hash_2)
    ans = {}
    hash_2.each do |k,v|
        ans[k] = v
    end

    hash_1.each do |k,v|
        if !(ans.include?(k))
            ans[k] = v
        end
    end
    return ans
end

def censor(sentence, arr)
    a = sentence.split(" ")
    a = a.map do |word|
        if arr.include?(word.downcase) #assuming here that arr is always provided in lowercase
            b = word.split("")
            b = b.map do |char|
                vowels = 'aeiouAEIOU'
                vowels.include?(char) ? "*" : char
            end
            word = b.join("")
        end
        word
    end
    a.join(" ")
end

def power_of_two?(num)
    return false if num <= 0
    counter = 1
    while (num>counter)
        counter = counter*2
    end
    if num == counter
        return true
    else #counter > num
        return false
    end
end
