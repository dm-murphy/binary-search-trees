# frozen_string_literal: true

require_relative 'node.rb'
require_relative 'tree.rb'

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
