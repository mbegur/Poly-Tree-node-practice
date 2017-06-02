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
    @visited_postions = []
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

  def generate_positions(pos)
    result = []
    DELTAS.each do | coord |
      result << [coord[0] + pos[0], coord[1] + pos[1]]
    end
    result
  end

  def self.valid_moves(pos)
    unvisited_pos = generate_positions(pos).reject do |coord|
      @visited_positions.include?(coord)
    end
    unvisited_pos.reject { |coord| coord.max > 7 && coord.min < 0}
  end



end
