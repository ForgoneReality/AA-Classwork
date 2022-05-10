def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    return true
end

def mersenne_prime(num)
    x = 2
    count = 0
    while(true)
        temp = (2 ** x) - 1
        if prime?((temp))
            count += 1
            if count == num
                return temp
            end
        end
        x += 1
    end
end

p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071