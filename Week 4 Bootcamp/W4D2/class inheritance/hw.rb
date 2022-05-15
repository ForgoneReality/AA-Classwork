class Employee
    attr_accessor :name, :title, :salary, :boss

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        salary * multiplier
    end
end

class Manager < Employee
    attr_accessor :subordinates
    def initialize(name, title, salary, boss)
        super
        @subordinates = []
    end

    def bonus(multiplier)
        a = 0
        @subordinates.each do |s|
            if s.is_a?(Manager)
                a += s.salary * multiplier 
            end
            a += s.bonus(multiplier)
        end
        return a
    end
end

ned = Manager.new("Ned", "Founder", 1000000, nil)
darren = Manager.new("Darren", "Manager", 78000, ned)
shawna = Employee.new("Shawna", "Employee", 12000, darren)
david = Employee.new("David", "Employee", 10000, darren) 
darren.subordinates << shawna
darren.subordinates << david
ned.subordinates << darren

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000