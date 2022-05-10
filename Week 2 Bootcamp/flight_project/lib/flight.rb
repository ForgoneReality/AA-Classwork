class Flight
    attr_reader :passengers

    def initialize(str, num)
        @flight_number = str
        @capacity = num
        @passengers = []
    end

    def full?
        if @passengers.length >= @capacity
            return true
        else
            return false
        end
    end

    def board_passenger(passenger)
        if passenger.has_flight?(@flight_number) && !full?
            @passengers << passenger
        end
    end

    def list_passengers
        @passengers.map {|p| p.name}
    end

    def [](num)
        @passengers[num]
    end

    def <<(passenger)
        board_passenger(passenger)
    end
end
