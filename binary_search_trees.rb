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
    # Bug: If value does not exist in tree => NoMethodError: undefined method 'data' for nil
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

  def smallest_left(node)
    current_node = node
    while current_node.left_child != nil
      current_node = current_node.left_child
    end
    return current_node
  end

  def delete(value, root_node = @root)
    if root_node.data == nil
      return root_node
    elsif value < root_node.data
      root_node.left_child = delete(value, root_node.left_child)
    elsif value > root_node.data
      root_node.right_child = delete(value, root_node.right_child)
    else
      if root_node.left_child == nil
        temp = root_node.right_child
        root_node = nil
        return temp
      elsif root_node.right_child == nil
        temp = root_node.left_child
        root_node = nil
        return temp
      end
      temp = smallest_left(root_node.right_child)
      root_node.data = temp.data
      root_node.right_child = delete(temp.data, root_node.right_child)
    end

    root_node
  end 
  
  def level_order(root_node = @root)
    # try recursion way too?
    return root_node if root_node.nil?

    queue = []
    queue.push(root_node)
    level_order_array = []
    until queue.empty?
      current_node = queue.last
      level_order_array.push(current_node.data)
      queue.unshift(current_node.left_child) unless current_node.left_child.nil?
      queue.unshift(current_node.right_child) unless current_node.right_child.nil?
      queue.pop
    end
    level_order_array
  end

  def preorder(root_node = @root, array = [])
    return root_node if root_node.nil?

    array.push(root_node.data)
    preorder(root_node.left_child, array)
    preorder(root_node.right_child, array)
    array
  end

  def inorder(root_node = @root, array = [])
    return root_node if root_node.nil?

    inorder(root_node.left_child, array)
    array.push(root_node.data)
    inorder(root_node.right_child, array)
    array
  end

  def postorder(root_node = @root, array = [])
    return root_node if root_node.nil?

    postorder(root_node.left_child, array)
    postorder(root_node.right_child, array)
    array.push(root_node.data)
    
  end
end

#bst = Tree.new(Array.new(15) { rand(1..100) })
#bst = Tree.new([3, 2, 1, 4, 8, 6, 7, 5, 8])
#bst = Tree.new([20, 30, 32, 34, 36, 40, 50, 60, 65, 70, 75, 80, 85])
bst = Tree.new([50, 30, 70, 20, 40, 60, 80, 35, 45, 65, 75, 85])
bst.pretty_print
puts
p bst.preorder
puts
p bst.inorder
puts
p bst.postorder
puts

puts bst.find(7)


#bst.insert(9)
#bst.pretty_print
#puts bst.find(70)
# bst.delete(20)
# bst.pretty_print
# bst.delete(30)
# bst.pretty_print
# bst.delete(50)
# bst.pretty_print
