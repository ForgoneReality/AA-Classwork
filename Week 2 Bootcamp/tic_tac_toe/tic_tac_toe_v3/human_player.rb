class HumanPlayer
    attr_reader :my_mark

    def initialize(m)
        @my_mark = m
    end

    def get_position(legal_positions)
        begin
            p "Please enter position with a space between the two numbers i.e. '1 2' to place #{my_mark}"
            inp = gets
            
            inp = inp.chomp
            numbers = "0123456789"
            a = inp.split(" ")

            if a.length != 2
                raise IOError.new("Invalid Input: Should have exactly two numbers")
            end

            a.each_with_index do |ele, i|
                ele.each_char do |c|
                    raise IOError.new("Invalid Input: Must only use numbers") if !numbers.include?(c)
                end
                a[i] = ele.to_i
            end
            
            if legal_positions.include?(a)
                return a
            else
                raise IOError.new("Invalid input: Not valid position")
            end

        rescue IOError => e 
            puts "Error Occurred: #{e}"
            retry
        end
    end


end
