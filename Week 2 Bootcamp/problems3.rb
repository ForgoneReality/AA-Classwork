def no_dupes?(arr)
    h = Hash.new(0)
    arr.each {|ele| h[ele] += 1}
    ans = []
    h.each do |v, k|
        ans << v if k == 1
    end
    ans
end

p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    #assuming non-empty
    last = arr[0]

    (1...arr.length).each do |i|
        if arr[i] == last
            return false
        else
            last = arr[i]
        end
    end
    return true
end

p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    h = Hash.new {|h, k| h[k] = []}
    str.each_char.with_index do |char, i|
        h[char] << i
    end
    h
end

# Examples
p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    best = str[0]
    streak = 1
    best_streak = 1

    (1...str.length).each do |i|
        if str[i] == str[i-1]
            streak += 1
        else
            if streak >= best_streak
                best_streak = streak
                best = str[i-1]
            end
            streak = 1
        end
    end
    if streak >= best_streak
        best_streak = streak
        best = str[-1]
    end
    best * best_streak
end

# Examples
p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'

def bi_prime?(num)
    primes = []
    iter = 2
    while iter <= num/2
        primes << iter if primes.none? {|prime| iter % prime == 0}
        iter += 1
    end

    (0...primes.length).each do |i|
        (0...primes.length).each do |j|
            if primes[i] * primes[j] == num
                return true
            end
        end
    end
    return false
end

# Examples
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false

def caesar_cipher(char, num)
    alphabet = "abcdefghijklmnopqrstuvwxyz"

    num = num % 26
    alphabet[(alphabet.index(char) + num) % 26]
end

def vigenere_cipher(message, keys)
    iter = 0
    message.each_char.with_index do |char, i|
        message[i] = caesar_cipher(message[i], keys[iter])
        iter += 1
        if iter == keys.length
            iter = 0
        end
    end
end

# Examples
p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    first = -1
    last = "b"
    vowels = "aeiou"
    str.each_char.with_index do |char, i|
        if vowels.include?(char)
            if(first == -1)
                first = i
                last = char
            else
                str[i] = last
                last = char
            end
        end
    end
    if first != -1
        str[first] = last
    end
    str
end

p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&p)
        ans = ''
        return ans if p.nil?

        self.each_char do |c|
            if p.call(c)
                ans += c 
            end
        end

        ans
    end

    def map!(&p)
        self.each_char.with_index do |c, i|
            self[i] = p.call(c, i)
        end
    end

end

# Examples
p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""

# Examples
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end

p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"



def multiply(a, b)
    if b == 0
        return 0
    elsif b < 0 
        0 - a + multiply(a, b+1)
    else
        a + multiply(a, b-1)
    end
end

# Examples
p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18

def lucas_sequence(num)
    if num == 0
        return []
    end
    return [2] if num == 1
    return [2, 1] if num == 2

    last = lucas_sequence(num-1)
    last << last[-1] + last[-2]
    last
end

# Examples
p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    if num == 1
        return []
    end

    (2..num).each do |n|
        if num % n == 0
            return [n] + (prime_factorization(num / n))
        end
    end
end


p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]

    
