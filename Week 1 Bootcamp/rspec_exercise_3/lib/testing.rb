a = []
b = [0, 1, 2]
a.push(b.dup) 
b[0] = 5
a.push(b.dup)

p a[0-1]