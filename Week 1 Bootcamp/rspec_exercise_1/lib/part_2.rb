def hipsterfy(word)
    index = -1
    i = word.length-1
    while i>=0
        if (word[i] == 'a' || word[i] == 'e' || word[i] == 'o' || word[i] == 'u' || word[i] == 'i')
            index = i
            break
        end
        i -= 1
    end
    if index != -1
        return word[0..i-1] + word[i+1..-1]
    else
        return word
    end

end

def vowel_counts(sentence)
    my_hash = Hash.new(0)
    sentence.each_char {|char| my_hash[char.downcase] += 1}
    return my_hash
end

def caesar_cipher(message, shift)
    shift = shift % 26
    ans = ""

    alphabet = "abcdefghijklmnopqrstuvwxyz"
    message.each_char do |char|
        x = alphabet.index(char)
        if x != nil
            ans += alphabet[(x + shift)%26] 
        else
            ans += char
        end
    end
    return ans
end
        

