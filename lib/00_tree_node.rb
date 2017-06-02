require 'byebug'

class PolyTreeNode

  attr_reader :value, :children, :parent

  def initialize(value, children = [], parent = nil)
    @value = value
    @children = children
    @parent = parent
  end

  def parent=(parent_node)
    return @parent = nil if parent_node.nil?
    @parent.children.delete(self) if @parent
    @parent = parent_node
    parent_node.children << self unless parent_node.children.include?(self)
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent= self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      @children.delete(child_node)
      child_node.parent = nil
    else
      raise 'No such child exists'
    end

  end

  def dfs(target_value)

    return self if @value == target_value

    @children.each do |child|
      target_node = child.dfs(target_value)
      return target_node if target_node
      # return child if child.value == target_value
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      next_node = queue.shift
      return next_node if next_node.value == target_value
      queue.concat(next_node.children)
    end
    nil
  end

  # def bfs(target_value)
  #   queue = [self]
  #   queue.each do |node|
  #     return node if node.value == target_value
  #     queue.concat(node.children)
  #     queue.shift
  #   end
  #   nil
  # end


end


# n1 = PolyTreeNode.new("root1",)
# n2 = PolyTreeNode.new("root2", [n4, n5], n1)
# n3 = PolyTreeNode.new("root3", [n6], n1)
# n4 = PolyTreeNode.new("root4", [], n2)
# n5 = PolyTreeNode.new("root5", [], n2)
# n6 = PolyTreeNode.new("root6", [], n3)
#
# n1.dfs(n4.value)
