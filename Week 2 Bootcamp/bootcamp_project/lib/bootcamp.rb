class Bootcamp
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new {|h,k| h[k] = []}
    end

    def name
        @name
    end

    def slogan
        @slogan
    end

    def teachers
        @teachers
    end

    def students
        @students
    end

    def hire(t)
        @teachers << t
    end

    def enroll(s)
        if @students.length < @student_capacity
            students << s
            return true
        else
            return false
        end
    end

    def enrolled?(s)
        @students.include?(s)
    end

    #Part 2

    def student_to_teacher_ratio #will have divide-by-zero error
        @students.length / @teachers.length 
    end

    def add_grade(s, g)
        if @students.include?(s)
            if @grades.include?(s)
                @grades[s] << g
            else
                @grades[s] = [g]
            end
        return true
        else
            return false
        end
    end

    def num_grades(s)
        if @grades.include?(s)
            return @grades[s].length
        else
            return nil
        end
    end


    def average_grade(s)
        return nil if !(@grades.include?(s))

        sum = @grades[s].inject {|acc, sum| acc + sum}
        return sum / @grades[s].length
    end
end
