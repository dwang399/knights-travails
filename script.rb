class Node
    attr_accessor :data, :neighbors
    def initialize(data = [nil,nil])
        @data = data
        @neighbors = [[data[0] + 2, data[1] + 1], [data[0] + 2, data[1] - 1], [data[0] - 2, data[1] + 1], [data[0] - 2, data[1] - 1], 
        [data[0] + 1, data[1] + 2], [data[0] + 1, data[1] - 2], [data[0] - 1, data[1] + 2], [data[0] - 1, data[1] - 2]]
        @neighbors = @neighbors.filter {|each| each[0] > 1 && each[0] < 9}
        @neighbors = @neighbors.filter {|each| each[1] > 1 && each[1] < 9}
    end

end

def knight_moves(start, destination)
    node = Node.new(start)
    path = []
    visited_nodes = node.neighbors
    visited_nodes.unshift(start)
    if start == destination 
        return 0
    end
    moves = 1
    until visited_nodes.include?(destination)
        moves += 1
        visited_nodes.each do |each|
            each = Node.new(each)
            visited_nodes += each.neighbors
        end
    end
    visited_nodes.uniq!
    target_node = destination
    node_stop = []
    until node_stop == start
        node_stop = visited_nodes.select {|parent| Node.new(parent).neighbors.include?(target_node)}
        node_stop = node_stop[0]
        index = visited_nodes.find_index(node_stop)
        visited_nodes = visited_nodes[0..index]
        if node_stop != start
            path.unshift(node_stop)
        end
        target_node = node_stop
    end
    path.unshift(start)
    path << destination
    return "You have made it in #{moves} move(s)! Your path was #{path}"
end

test = Node.new([1,1])
p knight_moves([1,1], [7,5])
