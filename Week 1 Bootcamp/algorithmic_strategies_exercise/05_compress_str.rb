# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".
def compress_str(str)
    ans = ""
    count = 1
    #assuming non-empty string
    (1..str.length-1).each do |i|
        if str[i] == str[i-1]
            count +=1
        elsif count == 1
            ans += str[i-1]
        else
            ans += count.to_s
            ans += str[i-1]
            count = 1
        end
    end

    ans += count.to_s if count > 1
    
    ans += str[-1]
    return ans
end


        

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
