class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
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
    node.left_child = build_tree(array[0...middle])
    node.right_child = build_tree(array[middle + 1..-1])
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def find(value, node = @root)
    return if node.nil?
    return node if node.data == value

    if node.data > value
      find(value, node.left_child)
    elsif node.data < value
      find(value, node.right_child)
    end
  end

  def insert(value, root_node = @root)
    return Node.new(value) if root_node.nil?
  
    if root_node.data == value
      return root_node
    elsif root_node.data < value
      root_node.right_child = insert(value, root_node.right_child)
    elsif root.data > value
      root_node.left_child = insert(value, root_node.left_child)
    end
    root_node
  end

  def smallest_left(node)
    current_node = node
    while current_node.left_child != nil
      current_node = current_node.left_child
    end
    current_node
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
    return root_node if root_node.nil?

    queue = []
    queue.push(root_node)
    level_order_array = []
    until queue.empty?
      level_order_array.push(queue.last.data)
      queue.unshift(queue.last.left_child) if queue.last.left_child
      queue.unshift(queue.last.right_child) if queue.last.right_child
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

  def height(value)
    node = find(value)
    find_height(node)
  end

  def find_height(node)
    return -1 if node.nil?

    left_height = find_height(node.left_child)
    right_height = find_height(node.right_child)
    [left_height, right_height].max + 1
  end

  def depth(value)
    node = find(value)
    find_depth(node)
  end

  def find_depth(node, counter = 0, root_node = @root)
    return counter if node == root_node

    if node.data < root_node.data
      find_depth(node, counter + 1, root_node.left_child)
    else
      find_depth(node, counter + 1, root_node.right_child)
    end
  end

  def balanced?
    left = find_height(root.left_child)
    right = find_height(root.right_child)
    left - right > 1 || right - left > 1 ? false : true
  end

  def rebalance
    array = level_order
    new_tree = array.uniq.sort
    @root = build_tree(new_tree)
  end
end

bst = Tree.new(Array.new(15) { rand(1..100) })
bst.pretty_print
puts
puts "Balanced:"
puts bst.balanced?
puts
puts "Level order:" 
p bst.level_order
puts
puts "Preorder:"
p bst.preorder
puts
puts "Postorder:"
p bst.postorder
puts
puts "Inorder:"
p bst.inorder
puts
puts "Inserting more numbers..."
bst.insert(1)
bst.insert(17)
bst.insert(37)
bst.insert(2)
bst.insert(4)
bst.insert(7)
bst.insert(6)
bst.insert(5)
bst.pretty_print
puts
puts "Balanced:"
puts bst.balanced?
puts
puts "Rebalancing..."
puts
bst.rebalance
bst.pretty_print
puts
puts "Balanced:"
puts bst.balanced?
puts
puts "Level order:" 
p bst.level_order
puts
puts "Preorder:"
p bst.preorder
puts
puts "Postorder:"
p bst.postorder
puts
puts "Inorder:"
p bst.inorder
