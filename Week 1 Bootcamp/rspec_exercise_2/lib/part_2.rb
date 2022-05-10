def palindrome?(str)
    if str.length % 2 == 0 #even
        (0...str.length / 2).each do |i|
            if str[i] != str[str.length - 1 - i]
                return false
            end
        end
        return true
    else #odd
        (0...(str.length / 2)).each do |i|
            if str[i] != str[str.length - 1 - i]
                return false
            end
        end
        return true
    end
end

def substrings(str)
    ans = []
    (0...str.length).each do |i| 
        start = ""
        (i...str.length).each do |j|
            start += str[j]
            ans << start
        end
    end
    return ans
end

def palindrome_substrings(str)
    a = substrings(str)
    a.select {|ele| ele.length > 1 && palindrome?(ele)}
end