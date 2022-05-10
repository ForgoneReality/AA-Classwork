def proper_factors(num)
    (1..num/2).select {|i| num%i == 0}
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    num == aliquot_sum(num)
end

def ideal_numbers(num)
    ans = []
    it = 1
    while(num > 0)
        if(perfect_number?(it))
            ans << it
            num -= 1
        end
        it += 1
    end
    ans
end
