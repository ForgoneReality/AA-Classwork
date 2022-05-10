# Write a method, `only_vowels?(str)`, that accepts a string as an arg.
# The method should return true if the string contains only vowels.
# The method should return false otherwise.
def only_vowels?(str)
    str.each_char do |char|
        if (char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u')
            next
        else
            return false
        end
    end
    return true
end

             

p only_vowels?("aaoeee")  # => true
p only_vowels?("iou")     # => true
p only_vowels?("cat")     # => false
p only_vowels?("over")    # => false


