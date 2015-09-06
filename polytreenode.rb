require 'byebug'

class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @children = []
    @value = value
  end

  def parent=(parent_node)
    @parent.children.delete(self) unless @parent == nil
    @parent = parent_node
    unless is_root_node? || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def is_root_node?
    @parent == nil
  end

  def add_child(child_node)
    raise "Trying to pass nil to add_child" if child_node == nil
    @children << child_node unless @children.include?(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Trying to pass nil to remove_child" if child_node == nil
    raise "Not a child of node" unless @children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      child_result = child.dfs(target_value)
      return child_result unless child_result.nil?
    end
    # end
    nil
  end

  def bfs(target_value)
    to_be_checked_nodes = [self]

    until to_be_checked_nodes.empty?
      current_node = to_be_checked_nodes.first
      return current_node if current_node.value == target_value
      to_be_checked_nodes += current_node.children
      to_be_checked_nodes.delete(current_node)
    end
    nil
  end
end
