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
    root = Node.new(array[middle])
    #puts array # Keep for debugging
    #puts root.data # Keep for debugging
    root.left_child = build_tree(array[0...middle])
    root.right_child = build_tree(array[middle + 1..-1])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end

#bst = Tree.new(Array.new(15) { rand(1..100) })
bst = Tree.new([3, 2, 1, 4, 8, 6, 7, 5, 8])
bst.pretty_print
