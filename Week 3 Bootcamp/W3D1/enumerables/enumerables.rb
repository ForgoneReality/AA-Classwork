class Array 
    def my_each(&prc)
        i = 0 
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        return self 
    end

    def my_select(&prc)
        new_arr = []

        self.my_each { |ele| new_arr << ele if prc.call(ele) }
        new_arr
    end

    def my_reject(&prc)
        self.reject { |ele| prc.call(ele) }
    end

    def my_any?(&prc)
        self.any? {|ele| prc.call(ele)}
    end

    def my_all?(&prc)
        self.all? {|ele| prc.call(ele)}
    end

    def flat_helper(array)
        new_arr = []
        array.each do |ele|
            if ele.kind_of?(Array)
                new_arr += flat_helper(ele)
            else
                new_arr += [ele]
            end
        end
        new_arr
    end

    def my_flatten
        new_arr = []
        self.each do |ele|
            if ele.kind_of?(Array)
                new_arr += flat_helper(ele)
            else
                new_arr += [ele]
            end
        end
        new_arr
    end
    

    def my_zip(*args)
        ans = []

        (0...self.length).each do |i|
            temp = []
            temp << self[i]
            args.each do |arg|
                temp << arg[i]
            end
            ans << temp
        end

        ans
        
    end

    def my_rotate(val=1)
        new_arr = self.dup
        if val > 0
            val = val % self.length
        elsif val < 0
            while(val < 0)
                val += self.length
            end
        else
            new_arr
        end

        val.times do
            ele = new_arr.shift
            new_arr.push(ele)
        end
        new_arr
    end

    def my_join(sep="")
        ans = "" 
        self.my_each do |ele|
            ans += ele + sep 
        end

        ans
    end

    def my_reverse
        i = self.length - 1
        new_arr = []
        while i >= 0
            new_arr << self[i]
            i -= 1
        end
        new_arr

    end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]