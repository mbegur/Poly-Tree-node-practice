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


end


class KnightPathFinder

  def initialize(current_position)
    @current_position = current_position
    @visited_positions = []
  end

  DELTAS = [
  [1, 2],
  [-1, 2],
  [1, -2],
  [-1, -2],
  [2, 1],
  [-2, 1],
  [2, -1],
  [-2, -1] ]

  def self.valid_moves(pos)
    result = []
    DELTAS.each do | coord |
      result << [coord[0] + pos[0], coord[1] + pos[1]]
    end
    result.reject { |coord| coord.max > 7 || coord.min < 0}
  end

  def new_move_positions(pos)

    KnightPathFinder.valid_moves(pos).reject do |coord|
      @visited_positions.include?(coord)
    end

  end

  def build_move_tree
    queue = [@current_position]

    until queue.empty?
      next_node = PolyTreeNode.new(queue.shift)
      next_pos = KnightPathFinder.new(next_node.value)

      children = next_pos.new_move_positions(next_node.value)

      children.each do |child|
        next_node.add_child(child)
        queue << child
      end
    end
  end

end

p current = KnightPathFinder.new([0,0])
p current.new_move_positions([1,2])
