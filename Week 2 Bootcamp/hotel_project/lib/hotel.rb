require_relative "room"

class Hotel
    attr_reader :rooms

    def initialize(name, h)
        @name = name

        @rooms = Hash.new
        h.each do |k, v|
            @rooms[k] = Room.new(v)
        end
    end

    def name
        a = @name.split(" ")
        b = a.each {|word| word.capitalize!}
        b.join(" ")
    end

    def room_exists?(room)
        @rooms.include?(room)
    end

    def check_in(person, room)
        if room_exists?(room)
            if @rooms[room].add_occupant(person)
                p "check in successful"
            else
                p "sorry, room is full"
            end
        else
            p "sorry, room does not exist"
        end
    end

    def has_vacancy?
        if @rooms.values.all? {|room| room.full?}
            return false
        else
            return true
        end
    end

    def list_rooms
        @rooms.each do |v, k|
            puts "#{v}.*#{k.available_space}"
        end
    end


end
