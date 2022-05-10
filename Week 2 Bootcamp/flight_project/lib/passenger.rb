class Passenger
    attr_reader :name

    def initialize(str)
        @name = str
        @flight_numbers = []
    end

    def has_flight?(str)
        @flight_numbers.include?(str.upcase)
    end

    def add_flight(str)
        if !has_flight?(str)
            @flight_numbers << str.upcase
        end
    end
end
