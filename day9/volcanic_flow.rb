def parse_volcano
  input = File.read("input.txt") 
  input.split("\n").map { |line| line.split("").map(&:to_i) }
end

def find_lows(volcanic_map)
   low_point_values = [] 
   volcanic_map.each_with_index.map do |row, y|
    row.each_with_index.map do |col, x|
        ## check all adjacent tiles
        up_taller = true
        down_taller = true
        left_taller = true
        right_taller = true
        
        current_height = volcanic_map[y][x]

        if y > 0
            up_taller = volcanic_map[y - 1][x] > current_height
        end

        if y < volcanic_map.length - 1
            down_taller = volcanic_map[y + 1][x] > current_height
        end

        if x > 0
            left_taller = volcanic_map[y][x - 1] > current_height
        end

        if x < volcanic_map[y].length - 1
            right_taller = volcanic_map[y][x + 1] > current_height
        end

        if up_taller && down_taller && left_taller && right_taller
            low_point_values << current_height + 1
        end
      end
    end
  low_point_values
end

def part_1
  volcanic_map = parse_volcano
  low_point_values = find_lows(volcanic_map)
  low_point_values.sum
end

p part_1

## now we need to find the basins
## a basin starts at a low point and spreads out until we find surrounding nines

def find_basin(volcanic_map)
  basin_sizes= []
  volcanic_map.each_with_index.map do |row, y|
   row.each_with_index.map do |col, x|
       ## check all adjacent tiles
       up_taller = true
       down_taller = true
       left_taller = true
       right_taller = true
       
       current_height = volcanic_map[y][x]

       if y > 0
           up_taller = volcanic_map[y - 1][x] > current_height
       end

       if y < volcanic_map.length - 1
           down_taller = volcanic_map[y + 1][x] > current_height
       end

       if x > 0
           left_taller = volcanic_map[y][x - 1] > current_height
       end

       if x < volcanic_map[y].length - 1
           right_taller = volcanic_map[y][x + 1] > current_height
       end

       if up_taller && down_taller && left_taller && right_taller
          basin_sizes << figure_out_basin(volcanic_map, x, y)
       end
     end
   end
   basin_sizes
end

def figure_out_basin(volcanic_map, x, y)
  current_height = volcanic_map[y][x]
  # check all adjacent tiles, repeat until we find a 9, then compute the area
  # and return it
  area = 0
  current_position = [x, y]

  volcanic_map[y][x] = 9
  area += 1

  if y > 0 && volcanic_map[y - 1][x] != 9
    area += figure_out_basin(volcanic_map, x, y - 1)
  end

  if y < volcanic_map.length - 1 && volcanic_map[y + 1][x] != 9
    area += figure_out_basin(volcanic_map, x, y + 1)
  end

  if x > 0 && volcanic_map[y][x - 1] != 9
    area += figure_out_basin(volcanic_map, x - 1, y)
  end

  if x < volcanic_map[y].length - 1 && volcanic_map[y][x + 1] != 9
    area += figure_out_basin(volcanic_map, x + 1, y)
  end

  area
end

def part_2
  volcanic_map = parse_volcano
  basin_sizes = find_basin(volcanic_map)
  basin_sizes.sort.reverse.first(3).inject(:*)
end

p part_2