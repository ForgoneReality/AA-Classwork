require "byebug"

def pretentious_primes(arr, ele)
    #assuming ele not 0
    primes = []
    iter = 2
    while iter <= arr.max 
        primes << iter if primes.none? {|prime| iter % prime == 0}
        iter += 1
    end

    if ele > 0 
        #expand primes
        i = 0

        while i < ele
            if primes.none? {|prime| iter % prime == 0}
                primes << iter
                i += 1
            end
            iter += 1
        end  
        arr2 = arr.map do |e|
            #can binary search technically
            j = 0
            while(e >= primes[j])
                j += 1
            end
            primes[j + ele - 1]
        end
        return arr2
    else
        arr2 = arr.map do |e|
            j = 0
            while(j < primes.length && e > primes[j])
                j += 1
            end
            temp = -1
            j + ele < 0 ? nil : primes[j + ele]
        end
        arr2
    end
end

p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]