require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.include?(title)
    end

    def >(other)
        self.funding > other.funding
    end

    def hire(employee, title)
        unless valid_title?(title)
            raise ArgumentError.new "Invalid Title Error"
        end

        n = Employee.new(employee, title)
        @employees << n
    end

    def size
        @employees.size
    end

    def pay_employee(emp)
        x = @salaries[emp.title]
        if @salaries[emp.title] > @funding
            raise RuntimeError.new "Not Enough Funds"
        else 
            emp.pay(x)
            @funding -= x
        end
    end

    def payday
        @employees.each do |emp|
            pay_employee(emp)
        end
    end

    #Part 3
    def average_salary
        a = @employees.sum {|emp| @salaries[emp.title]}
        a / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other)
        @funding += other.funding
        other.salaries.each do |v, k|
            if !(@salaries.include?(v))
                @salaries[v] = k
            end
        end
        @employees += other.employees
        other.close
    end

end
