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
    #remove child from parent's @child_array
    #deal with nil entry
    #deal with not child removal -- raise error alert
  end

end


# n1 = PolyTreeNode.new("root1")
# n2 = PolyTreeNode.new("root2")
# n3 = PolyTreeNode.new("root3")
