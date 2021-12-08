def populate_current_pop
    new_hash = {}
    keys = [0,1,2,3,4,5,6,7,8]
    keys.each { |key| new_hash[key] = 0}

    values = File.readlines("input.txt")[0].split(",").map(&:to_i)

    values.each do |v|
        new_hash[v] += 1
    end

    new_hash
end

def increase_pop(current_pop)
    new_hash = {}
    keys = [0,1,2,3,4,5,6,7,8]
    keys.each { |key| new_hash[key] = 0}
    current_pop.each do |k, v|
        if k == 0 
            new_hash[8] += v
            new_hash[6] += v
        else
            new_hash[k-1] += v
        end
    end  
    new_hash
end

def run_x_times(x)
    current_pop = populate_current_pop
    x.times do
        current_pop = increase_pop(current_pop)
    end
    fish_total(current_pop)
end

def fish_total(current_pop)
    total = current_pop.values.reduce(:+)
end

p run_x_times(256)