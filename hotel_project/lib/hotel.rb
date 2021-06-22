require_relative "room"

class Hotel
    def initialize(name, capacities)
        @name = name
        @rooms = {}

        #for each room in the capacities hash,
        capacities.each do |k, v|#room name and capacity per room
            @rooms[k] = Room.new(v)#init Room with the capacity value
        end 
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
        #split the name, map characters from array with capitalize method and rejoin
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        if @rooms.include?(name)
            return true
        else return false
        end
    end

    def check_in(person, room_name)
        if self.room_exists?(room_name)
            #let's try to add the occupant which shoyld return true/F
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else 
                puts "sorry, room is full"
            end

        else #or else room doesn't exist
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
         #check for any empty rooms which are stored by values
        return @rooms.values.any? { |room| room.available_space > 0 }
    end

    def list_rooms
        @rooms.each do |room_name, room|
            #use string interpolation to return all the room names and rooms with available space
            puts "#{room_name} : #{room.available_space}"
        end
    end
end
