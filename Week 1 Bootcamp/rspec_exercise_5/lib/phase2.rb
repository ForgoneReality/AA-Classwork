
def conjunct_select(arr, *args)
    ans = arr.select do |ele|
        args.all? {|p| p.call(ele)}
    end
    ans
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def convert_pig_latin(sentence)
    a = sentence.split(" ")
    vowels = "aeiouAEIOU"
    ans = a.map do |word|
        if word.length >= 3
            if vowels.include?(word[0])
                word += "yay"
            else
                ind = -1
                (1...word.length).each do |i|
                    if vowels.include?(word[i])
                        ind = i
                        break 
                    end
                end
                if ind!=-1
                    if word[0].upcase == word[0]
                        word = (word[ind..-1] + word[0...ind] + "ay").capitalize
                    else
                        word = (word[ind..-1] + word[0...ind] + "ay")
                    end
                else
                    word += "ay"
                end
            end
        end
        word
    end
    ans.join(" ")
end

p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(sentence)
    a = sentence.split(" ")

    a.map! do |word|
        vowels = "aeiouAEIOU"
        if word.length >= 3
            i = word.length-1
            while(i>=0)
                if vowels.include?(word[i])
                    break
                end
                i -= 1
            end
            if i == -1
                word
            elsif i == word.length - 1
                word = word * 2
            else
                word += word[i..-1]
            end
        end
        word
    end
    a.join(" ")
end
    #not sure what to do in case where greater than 3 but has no vowel

p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *args)
    ans = arr.select do |ele|
        args.any? {|p| p.call(ele)}
    end
    ans
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
) # ["apple", "teeming"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o
) # ["dog", "apple", "teeming", "boot"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o,
    starts_a
) # ["ace", "dog", "apple", "teeming", "boot"]

def alternating_vowel(sentence)
    first = true
    a = sentence.split(" ")
    vowels = "aeiou"
    a.map! do |word|
        if first
            first = false
            i = 0
            while(i<word.length)
                if vowels.include?(word[i])
                    word = word[0...i] + word[i+1..-1]
                    break
                end
                i+= 1
            end
        else
            first = true
            i = word.length - 1
            while(i>=0)
                if vowels.include?(word[i])
                    word = word[0...i] + word[i+1..-1]
                    break
                end
                i-=1
            end
        end
        word
    end
    a.join(" ")
end

p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
p alternating_vowel('code properly please') # "cde proprly plase"
p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_talk(sentence)
    a = sentence.split(" ")
    vowels = "aeiouAEIOU"
    a.map! do |word|
        if vowels.include?(word[-1])
            word += word[-1]
        else
            b = word.split("")
            b.map! do |char|
                char += "b" if b.include?(char)
                char
            end
            b.join("")
        end
    end
    a.join(" ")
end

p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
p silly_talk('They can code') # "Thebey caban codee"
p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"


# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".
def compress(str)
    ans = ""
    count = 1
    #assuming non-empty string
    (1..str.length-1).each do |i|
        if str[i] == str[i-1]
            count +=1
        elsif count == 1
            ans += str[i-1]
        else
            ans += str[i-1]
            ans += count.to_s
            count = 1
        end
    end
    
    ans += str[-1]
    ans += count.to_s if count > 1
    return ans
end

p compress('aabbbbc')   # "a2b4c"
p compress('boot')      # "bo2t"
p compress('xxxyxxzzzz')# "x3yx2z4"