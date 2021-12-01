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

def calculate_number_of_increments_in_threes(input_arr)
    total_number_of_increments = 0
    starting_index = 0
    leading_index = 2    
    last_sum = input_arr[starting_index] + input_arr[starting_index + 1] + input_arr[leading_index]
    starting_index += 1
    leading_index += 1
    while input_arr[leading_index+1] != nil
        starting_index += 1
        leading_index += 1
        new_sum = input_arr[starting_index] + input_arr[(starting_index + 1)] + input_arr[leading_index]
        if new_sum > last_sum
            total_number_of_increments += 1
        end
        last_sum = new_sum
    end
    total_number_of_increments
end

p calculate_number_of_increments_in_threes(input_arr)
