# frozen_string_literal: true

# Operates nodes for binary search tree
class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end
