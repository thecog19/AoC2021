coords = File.readlines("input.txt").map do |line|
    l, r = line.split(" -> ")
    [*l.split(",").map(&:to_i), *r.split(",").map(&:to_i)]
end
  
X = coords.flat_map { |c| [c[0], c[2]] }.max + 1
Y = coords.flat_map { |c| [c[1], c[3]] }.max + 1

G1 = Array.new(Y) { Array.new(X, 0) }
G2 = Array.new(Y) { Array.new(X, 0) }
  
coords.each do |x1, y1, x2, y2|
    straight = x1 == x2 || y1 == y2

    pos = [x1, y1]
    while pos != [x2, y2]
        x, y = pos

        G1[y][x] += 1 if straight
        G2[y][x] += 1

        if x1 < x2
        x += 1
        elsif x1 > x2
        x -= 1
        end

        if y1 < y2
        y += 1
        elsif y1 > y2
        y -= 1
        end

        pos = [x, y]
    end
    G1[y2][x2] += 1 if straight
    G2[y2][x2] += 1
end
puts G1.flatten.count { |c| c >= 2}
puts G2.flatten.count { |c| c >= 2}