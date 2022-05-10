require "byebug"

#check below if it satisfies the obvious requirement of needing least primes (so as many multiples as possible)
#return the prime factorization if so, return empty hash if not

def pre_check(num)
    my_hash = Hash.new(0)
    factor = 2

    primes = []
    while(num > 1)
        if my_hash.include?(factor) #already a previous prime factor 
            if num % factor == 0
                my_hash[factor] += 1
                num = num / factor
                factor = 2
            else
                factor += 1
            end
        else #new factor, potentially non-prime
            if primes.none? { |prime| factor % prime == 0} #confirmed it is a NEW prime factor
                primes << factor
                #idea: now at this point, must have this prime number or dead
                if num % factor == 0
                    my_hash[factor] += 1
                    num = num / factor
                    factor = 2
                else
                    return {}
                end
            else #composite
                factor += 1 
            end
        end
    end

    if (0...primes.length-1).all? {|i| my_hash[primes[i]] >= my_hash[primes[i+1]]}
        return my_hash
    else
        return {}
    end
end


# def next_prime(primes)
#     num = primes[-1] + 1
#     while true #we will find a prime eventually...
#         if primes.none? { |prime| num % prime == 0}
#             return num
#         else
#             num += 1
#         end
#     end
# end

def possibilities (num)
    primes = []
    new_prime = 2
    blocks = []
    so_far = 1

    while(so_far < num)
        if primes.none? { |prime| new_prime % prime == 0}
            so_far = so_far * new_prime #!!!! because it cant be greater in quantity than previous primes
            if (so_far > num)
                break
            end
            primes << new_prime
            blocks << so_far
        end
        new_prime += 1
    end
    return blocks

end

def score(arr)
    holder = Array.new(arr.length, 1) #importantly starts at 1
    (1...arr.length).each do |i|
        (i...arr.length).each do |j|
            holder[j] += arr[i]
        end
    end
    
    acc = 1
    (1...holder.length).each do |i|
        acc = acc * holder[i]
    end
    
    return acc
end


#for a number to be, anti-prime, it must be the sum of a smallest 
#set of prime factors

#24 = 2 * 2 * 2 * 3

#30 = 2 * 3 * 5 <- bad because 2*2 is less than 5, but counts as 2

#36 = 2 * 2 * 3 * 3

#think in terms of binary, and use fact we have PRIMES and SMALLEST of them


def anti_prime?(num)
    if num <= 0 
        return false
    elsif num == 1 || num == 2 #edge cases where 1 and prime number 2 are anti_prime, all others are composite
        return true
    else
        seen = false

        prime_factors = pre_check(num)
        if prime_factors.empty? 
            return false
        end

        div_goal = 1
        prime_factors.each_value do |v|
            div_goal = div_goal * (v + 1) #+1 because could be none of this particular one
        end
        
        blocks = possibilities(num)

        my_stack = []

        #let 0th index be the size thus far
        if blocks.length > 1 #ignore... just to fit a NIL bug ONLY for anti_prime?(4)
            (0..Math.log(num, blocks[-1]).to_i).each do |n|
                a = []
                a << blocks[-1] ** n 
                a << n
                my_stack.push(a.dup)
            end
        end
        
        while(!my_stack.empty?)
            top = my_stack.pop
            i = blocks.length - top.length
            if(i == 0) #all but the 2's done
                twos = 0
                while top[0] * 2 <= num
                    twos += 1
                    top[0] = top[0]*2
                end
                top << twos
                if score(top) > div_goal
                    return false
                elsif score(top) == div_goal
                    if seen
                        return false
                    else
                        seen = true
                    end
                end
            else 
                top << 0
                my_stack.push(top.dup)
                while(blocks[i] * top[0] <= num)
                    top[-1] += 1
                    top[0] = top[0] * blocks[i]
                    my_stack.push(top.dup)
                end
            end
        end
    return true
    #beware shallow copy
        
            
            
    end
end

 p anti_prime?(4)
# p anti_prime?(24)   # true
# p anti_prime?(36)   # true
# p anti_prime?(48)   # true
# p anti_prime?(360)  # true
# p anti_prime?(1260) # true
# p anti_prime?(27)   # false
# p anti_prime?(5)    # false
# p anti_prime?(100)  # false
# p anti_prime?(136)  # false
# p anti_prime?(1024) # false



(1...100000).each {|i| p i if anti_prime?(i)}