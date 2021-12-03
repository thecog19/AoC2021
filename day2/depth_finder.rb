input_arr = []

File.readlines('input.txt').each do |line|
    input_arr.append(line.strip)
end

def depth_finder(arr)
    x_coord = 0
    y_coord = 0 
    arr.each do |input|
        number = input.split(" ")[1].to_i
        direction = input.split(" ")[0]

        if direction == "up"
            y_coord -= number
        elsif direction == "down"
            y_coord += number
        elsif direction == "forward"
            x_coord += number
        elsif direction == "backward"
            x_coord -= number
        end
    end

    return x_coord * y_coord
end

def depth_finder_with_aim(arr)

    x_coord = 0
    y_coord = 0
    #aim represents momentum of the submarine
    aim = 0

    arr.each do |input|
        number = input.split(" ")[1].to_i
        direction = input.split(" ")[0]

        if direction == "up"
            aim -= number
        elsif direction == "down"
            aim += number
        elsif direction == "forward"
            x_coord += number
            y_coord += aim*number
        elsif direction == "backward"
            x_coord -= number
            y_coord -= aim*number
        end
    end

    return x_coord * y_coord
end

p depth_finder(input_arr)
p depth_finder_with_aim(input_arr)
