def generate_anagrams(str, length)
    return [str] if length <= 1
    anagrams = [] 
    length.times do
        rem = str[str.length - length]
        str.slice!(str.length - length)
        str = str + rem
        s = str.dup
        anagrams.concat(generate_anagrams(s, length - 1))
    end
    return anagrams
end

def first_anagram?(string_1, string_2)
    generate_anagrams(string_1, string_1.length).include?(string_2)
end

#O(n!), gets very slow quickly

def second_anagram?(string_1, string_2)
    string_1.each_char do |char|
        i = string_2.index(char)
        if i != nil
            string_2.slice!(i)
        else
            return false
        end
    end

    return true if string_2.empty?
end

#O(n^2)

def third_anagram?(string_1, string_2)
    string_1.chars.sort.join == string_2.chars.sort.join
end

#O(n log n)

def fourth_anagram?(string_1, string_2)
    if string_1.length != string_2.length
        return false
    end
    hash = Hash.new(0)
    string_1.each_char {|char| hash[char] += 1}
    string_2.each_char do |char|
        if hash[char] <= 0
            return false
        end
        hash[char] -= 1
    end
    return true
end

#O(n)

# p fourth_anagram?("gizmo", "sally")    #=> false
# p fourth_anagram?("elvis", "lives")    #=> true