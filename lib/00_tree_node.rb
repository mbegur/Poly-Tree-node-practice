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

end
