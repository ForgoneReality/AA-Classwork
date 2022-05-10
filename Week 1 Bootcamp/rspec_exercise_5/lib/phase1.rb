def duos(str)
    return 0 if str.empty?

    last = str[0]

    count = 0
    (1...str.length).each do |i|
        if str[i] == last
            count += 1
        end
        last = str[i]
    end

    return count
end

p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0

def sentence_swap(sentence, h)
    a = sentence.split(" ")
    a.each_with_index do |word, i|
        if h.include?(word)
            a[i] = h[word]
        end
    end
    a.join(" ")
end

p sentence_swap('anything you can do I can do',
    'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'

p sentence_swap('what a sad ad',
    'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'

p sentence_swap('keep coding okay',
    'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'

def hash_mapped(h, p1, &p2)
    new_h = {}
    h.each do |v, k|
        new_h[p2.call(v)] = p1.call(k)
    end
    new_h
end

double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}

def counted_characters(str)
    counter = Hash.new(0)
    str.each_char do |char|
        counter[char] += 1
    end

    ans = []
    counter.each { |k, v| ans << k if counter[k] > 2 } 
    ans
end

p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []

def triplet_true?(str)
    return false if str.empty?

    last = str[0] 
    count = 1
    (1...str.length).each do |i|
        if str[i] == last
            count += 1
            if count >= 3
                return true
            end
        else
            count = 1
            last = str[i]
        end
    end
    return false
end

p triplet_true?('caaabb')        # true
p triplet_true?('terrrrrible')   # true
p triplet_true?('runninggg')     # true
p triplet_true?('bootcamp')      # false
p triplet_true?('e')             # false

def energetic_encoding(str, h)
    a = str.split("")
    a.each_with_index do |char, index|
        if char != " "
            if h.include?(char)
                a[index] = h[char]
            else
                a[index] = "?"
            end
        end
    end
    a.join("")
end

p energetic_encoding('sent sea',
    'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'

p energetic_encoding('cat',
    'a'=>'o', 'c'=>'k'
) # 'ko?'

p energetic_encoding('hello world',
    'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'

p energetic_encoding('bike', {}) # '????'

def uncompress(string)
    #assuming format is proper and passed in proper string
    i = 0 
    ans = ""
    while i<string.length
        ans += string[i] * string[i+1].to_i
        i+= 2
    end
    ans
end

p uncompress('a2b4c1') # 'aabbbbc'
p uncompress('b1o2t1') # 'boot'
p uncompress('x3y1x2z4') # 'xxxyxxzzzz'