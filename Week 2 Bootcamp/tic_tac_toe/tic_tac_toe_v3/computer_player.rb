class ComputerPlayer
    attr_reader :my_mark

    def initialize(m)
        @my_mark = m
    end

    def get_position(legal_positions)
        legal_positions.sample
    end

end
