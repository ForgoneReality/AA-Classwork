def is_prime?(num)
    if num < 2
        return false
    elsif num ==2 
        return true
    else
        (2..Math.sqrt(num).ceil).each {|n| return false if num % n == 0}
    end
    return true
end

def nth_prime(num)
    start = 2
    primes = []
    while(num>0)
        if primes.none? { |prime| start % prime == 0}
            num -= 1
            primes << start
        end
        start += 1
    end
    primes[-1]
end

def prime_range(min, max)
    start = 2
    primes = []
    ans = []
    while(max>=start)
        if primes.none? { |prime| start % prime == 0}
            primes << start
            if(start>=min)
                ans << start
            end
        end
        start += 1
    end
    ans
end
    