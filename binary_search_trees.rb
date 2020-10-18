class Node
  #include Comparable
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  # def compare
  #   @left_child <=> @right_child
  # end
end

class Tree
  attr_accessor :root

  def initialize(array)
    tree_array = array.uniq.sort
    @root = build_tree(tree_array)
  end

  def build_tree(array)
    return nil unless array.last

    middle = (array.length - 1) / 2
    node = Node.new(array[middle])
    #puts array # Keep for debugging
    #puts root.data # Keep for debugging
    node.left_child = build_tree(array[0...middle])
    node.right_child = build_tree(array[middle + 1..-1])
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def find(value, root_node = @root)
    return root_node if root_node.data == nil || root_node.data == value

    if root_node.data > value
      return find(value, root_node.left_child)
    elsif root_node.data < value
      return find(value, root_node.right_child)
    end
  end

  def insert(value, root_node = @root)
    return Node.new(value) if root_node == nil
  
    if root_node.data == value
      return root_node
    elsif root_node.data < value
      root_node.right_child = insert(value, root_node.right_child)
    elsif root.data > value
      root_node.left_child = insert(value, root_node.left_child)
    end
    return root_node
  end

  # def delete(root, value)
  # end

  
end

#bst = Tree.new(Array.new(15) { rand(1..100) })
bst = Tree.new([3, 2, 1, 4, 8, 6, 7, 5, 8])
bst.pretty_print
bst.insert(9, bst.root)
bst.pretty_print
puts bst.find(7)
