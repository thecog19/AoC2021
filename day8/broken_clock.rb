def parse_clock_input(path)
    lines = File.readlines(path).map(&:chomp)
    lines.map! { |line| line.split('|') }
    lines
end

@clock_input = parse_clock_input('input.txt')

def establish_counts(input)
    counts = {}
    input.each do |line|
        postfix = line[1]
        postfix.split(" ").each do |word|
            word_length = word.length
            counts[word_length] = 0 unless counts[word_length]
            counts[word_length] += 1
        end
    end
    counts
end

def sum_counts(counts)
    counts[2] + counts[3] + counts[7] + counts[4]
end

def compute_unique_numbers(input)
    counts = establish_counts(input)
    sum_counts(counts)
end 

p compute_unique_numbers(@clock_input)

## Part 2

def decode_clock(input)
    total = 0
    input.each do |line|
        decoded_values = decode_numbers(line)
        postfix = line[1]
        num_string = ""
        postfix.split(" ").each do |word|
            s_word = word.split("").sort.join("")
            num_string += decoded_values[s_word].to_s
        end
        total += num_string.to_i
    end
    total
end

def print_clock(input)
    input.each do |line|
        decoded_values = decode_numbers(line)
        postfix = line[1]

        postfix.split(" ").each do |word|
            
            p_word = decoded_values[s_word].to_s
            p_word = "X" if p_word.length == 0
            print p_word + " "
        end
        print "\n" 
    end
end

def decode_numbers(input)
    #we take a single line of input and split it into an array of words
    #the left side of the array contains all ten numbers
    #the right contains our final code
    #we need to find rules to define all the numbers from the left side

    left_side = input[0].split(" ")

    left_side_hash = {}
    left_side.each do |number|
        number = number.split("").sort.join("")
        num_len = number.length
        left_side_hash[num_len] = [number] unless left_side_hash[num_len]
        left_side_hash[num_len] << number      
        left_side_hash[num_len] = left_side_hash[num_len].uniq
    end

    decoded_values = {}

    value_to_code = {}

    decoded_values[left_side_hash[2][0].split("").sort.join("")] = 1
    decoded_values[left_side_hash[4][0].split("").sort.join("")] = 4
    decoded_values[left_side_hash[3][0].split("").sort.join("")] = 7
    decoded_values[left_side_hash[7][0].split("").sort.join("")] = 8 

    decoded_values.each do |key, value|
        value_to_code[value] = key
    end

    middle_and_top_rails = []
    #two, three, five, all have 5 characters
    middle_rails = left_side_hash[5].flatten.map{|e| e.split("")}
    middle_rails = middle_rails.inject{|a,e| a & e}
   
    #using the rails we can figure out the identity of zero, which is the only
    # six character number without a match in the middle rails

    zero = find_zero(left_side_hash[6], middle_rails)
    decoded_values[zero] = 0
    value_to_code[0] = zero

    left_side_hash[6].delete(zero)
    
    six, nine = find_six_and_nine(left_side_hash[6], value_to_code[1])

    decoded_values[six] = 6
    decoded_values[nine] = 9
    value_to_code[6] = six
    value_to_code[9] = nine

    five = find_five(left_side_hash[5], value_to_code[6])

    decoded_values[five] = 5
    value_to_code[5] = five

    left_side_hash[5].delete(five)

    two, three = find_two_and_three(left_side_hash[5], value_to_code[1])
    decoded_values[two] = 2
    decoded_values[three] = 3

    value_to_code[2] = two
    value_to_code[3] = three

    return decoded_values
end

#six and nine and zero have 6 characters

def find_zero(potentials, middle_rails)
    potentials.each do |potential|
        potential = potential.split("")
        contains_rails = (middle_rails - potential).length == 0
        return potential.join("") if !contains_rails
    end
end

#nine contains all of one
#six does not
#return 6 and 9 in that order
def find_six_and_nine(potentials, one)
    test_1 = one.split("") - potentials[0].split("") 
    test_2 = one.split("") - potentials[1].split("")

    if test_1.length == 0
        return potentials[1], potentials[0]
    else
        return potentials[0], potentials[1]
    end

end
#two, three, five, all have 5 characters
#six has full overlap with three and two but not five
def find_five(potentials, six)
    six = six.split("")
    potentials.each do |potential|
        potential = potential.split("")
        has_overlap = (six - potential).length == 1
        return potential.join("") if has_overlap
    end
end

#three fully overlaps with one
#two does not
#return 2 and 3 in that order
def find_two_and_three(potentials, one)
    test_1 = one.split("") - potentials[0].split("") 
    test_2 = one.split("") - potentials[1].split("")

    if test_1.length == 0
        return potentials[1], potentials[0]
    else
        return potentials[0], potentials[1]
    end
 
end

p decode_clock(@clock_input)