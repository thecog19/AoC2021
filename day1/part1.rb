input_arr = []

File.readlines('input.txt').each do |line|
    input_arr.append(line.strip.to_i)
end

def calculate_number_of_increments(input_arr)
    total_number_of_increments = 0
    previous_number = input_arr[0]
    input_arr.each do |number|
        if number > previous_number
            total_number_of_increments += 1
        end
        previous_number = number
    end
    total_number_of_increments
end

p calculate_number_of_increments(input_arr)
