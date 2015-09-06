require_relative  'polytreenode.rb'

class KnightPathFinder
  attr_accessor :pos, :visited_positions
  OFFSETS = [[-2,-1], [-2,1], [-1,-2], [-1,2], [1,-2], [1,2], [2,-1], [2,1]]

  def initialize(pos)
    @pos = PolyTreeNode.new(pos)
    @visited_positions = [ PolyTreeNode.new(pos) ]
  end

  def find_path(end_pos)
    # Iterate through the parents until you find the root(initial position).
    target_node = build_move_tree(end_pos)
    path = []
    until target_node.parent == nil
      path << target_node.value
      target_node = target_node.parent
    end
    [pos.value] + path.reverse
  end

  def build_move_tree(target_pos)
    queue = new_move_positions(pos)
    until queue.empty?
      current_node = queue.first
      return current_node if current_node.value == target_pos
      queue += new_move_positions(current_node)
      queue.delete(current_node)
    end
    # nil
  end

  def new_move_positions(start_node)
    KnightPathFinder::valid_moves(start_node).reject do |node|
      @visited_positions.include?(node)
    end
  end

  def self.valid_moves(node)
    pos = node.value
    pathspace = []
    OFFSETS.each do |offset|
      row, col = (offset[0] + pos[0]), (offset[1] + pos[1])
      child_node = PolyTreeNode.new([row,col])
      child_node.parent = node
      node.add_child(child_node)
      pathspace << child_node unless self.out_of_bounds?(child_node.value)
    end
    pathspace
  end

  def self.out_of_bounds?(node_val)
    pos = node_val
    raise "Invalid Position" unless pos.is_a?(Array)
    return false if ((pos[0] > 0 && pos[0] < 8) && (pos[1] > 0 && pos[1] < 8))
    true
  end
end

k =  KnightPathFinder.new([0,0])
p k.find_path([7,7])
