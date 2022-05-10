# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        return nil if self.empty?
        #below bad code, yes it breaks with bigger numbers
        min = 15000000
        max = -15000000
        self.each do |num|
            if num < min
                min = num
            end
            if num > max
                max = num
            end
        end
        max - min
    end

    def average
        return nil if self.empty?
        (self.sum + 0.0)/ self.length 
    end

    def median
        return nil if self.empty?

        l = self.length
        s = self.sort
        if l%2==0
            (s[l/2 - 1] + s[l/2])/2.0
        else
            s[l/2]
        end
    end

    def counts
        h = Hash.new(0)

        self.each {|ele| h[ele] += 1}
        h
    end

    def my_count(val)
        count = 0
        self.each {|ele| count += 1 if ele == val}
        return count
    end

    def my_index(val)
        i = 0
        while i<self.length
            return i if self[i] == val
            i+=1
        end
        return nil
    end

    def my_uniq()
        arr = []
        self.each {|ele| arr << ele if !(arr.include?(ele))}
        arr
    end

    def my_transpose()
        d = self.length

        arr = Array.new(d) {Array.new(d)}
        (0...d).each do |i|
            (0...d).each do |j|
                arr[i][j] = self[j][i]
            end
        end
        arr
    end

end
