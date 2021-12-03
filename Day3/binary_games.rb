input_arr = []

File.readlines('input.txt').each do |line|
    input_arr.append(line.strip)
end

def part_1(input_arr)
    gamma, epsilon = find_rates(input_arr)
    calculate_solution(gamma, epsilon)
end

def find_rates(input_arr)
    total_elements = input_arr.length
    one_count = []

    input_arr.each do |element|
        element.split('').each_with_index do |char, i|
            if char == '1'
                if one_count[i] == nil
                    one_count[i] = 1
                else
                    one_count[i] += 1
                end
            end
        end
    end

    zero_count = one_count.map { |x| total_elements - x }

    generate_rates(zero_count, one_count)
end

def generate_rates(zero_count, one_count)
    gamma = []
    epsilon = []
    zero_count.each_with_index do |zero, i|
        one = one_count[i]
        if one > zero
            gamma << 1
            epsilon << 0
        elsif zero > one
            gamma << 0
            epsilon << 1
        else
            puts "Error"
            raise "Error"
        end
    end
    return gamma, epsilon
end

def calculate_solution(bin1, bin2)
    bin1.join('').to_i(2) * bin2.join('').to_i(2)
end

## part 2

def part_2(input_arr)
    gamma, epsilon = find_rates(input_arr)
    oxy, o2 = filter_through_game(gamma, epsilon, input_arr)
    p oxy
    p o2
    calculate_solution(oxy, o2)
end

def filter_through_game(gamma, epsilon, input_arr)
    gamma = gamma.map { |x| x.to_s }
    epsilon = epsilon.map { |x| x.to_s }

    oxygen_system = []
    co2_system = []

    ## first split the array into two arrays based on the gamma and epsilon

    oxy_deteminant = gamma[0]
    co2_determinant = epsilon[0]

    oxy_array = []
    co2_array = []

    input_arr.each do |element|
        if element[0] == oxy_deteminant
            oxy_array.append(element)
        else
            co2_array.append(element)
        end
    end

    ## now we have two arrays, one for oxygen and one for carbon dioxide
    ## we need to further filter these arrays based on the epsilon and gamma
    
    times_to_iterate = input_arr[0].length - 1
    index = 1

    while index <= times_to_iterate
        oxy_zero_count = oxy_array.map { |x| x[index] }.count('0')
        oxy_one_count = oxy_array.length - oxy_zero_count
        co2_zero_count = co2_array.map { |x| x[index] }.count('0')
        co2_one_count = co2_array.length - co2_zero_count

        bigger = "0"
        smaller = "1"

        bigger = "1" unless oxy_zero_count > oxy_one_count
        smaller = "0" unless co2_one_count < co2_zero_count

        oxy_array.filter! { |element| element[index] == bigger } unless oxy_array.length == 1
        co2_array.filter! { |element| element[index] == smaller } unless co2_array.length == 1
        index += 1

        if co2_array.length == 1 && oxy_array.length == 1
            return oxy_array, co2_array
        end
    end

    return oxy_array, co2_array
end

p part_1(input_arr)
p part_2(input_arr)

