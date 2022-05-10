def triangular_word?(word)
    sum = 0
    word.each_char do |char|
        sum += char.ord - 96
    end
    
    i = 0

    x = 0
    
    while(x < sum)
        i += 1
        x = (i * (i+1))/2
    end

    if x == sum
        return true
    else
        return false
    end
end

p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false