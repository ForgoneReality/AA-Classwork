def pascals_triangle(n)
    a = []
    if n == 0
        return a
    end
    a << [1]
    if n == 1
        return a
    end
    a << [1, 1]
    if n == 2
        return a
    end

    #bruh this ugly af

    i = 3
    while i<= n
        temp = [1]
        last = a[-1]
        (0...last.length-1).each do |j|
            temp << last[j] + last[j+1]
        end
        temp << 1
        a << temp
        i += 1
    end
    return a
end

p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]
