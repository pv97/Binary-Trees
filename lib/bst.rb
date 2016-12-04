class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root = BinarySearchTree.insert!(@root,value)
  end

  def find(value)
    BinarySearchTree.find!(@root,value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    return nil if @root.nil?
    BinarySearchTree.min(@root)
  end

  def max
    return nil if @root.nil?
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root,value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node

    if value <= node.value
      if node.left == nil
        new_node = BSTNode.new(value)
        node.left = new_node
      else
        BinarySearchTree.insert!(node.left, value)
      end
    else
      if node.right == nil
        new_node = BSTNode.new(value)
        node.right = new_node
      else
        BinarySearchTree.insert!(node.right, value)
      end
    end
    return node
  end

  def self.find!(node, value)
    return nil if node.nil?
    return node if node.value == value
    if node.value > value
      BinarySearchTree.find!(node.left,value)
    else
      BinarySearchTree.find!(node.right,value)
    end
  end

  def self.preorder!(node)
    return unless node
    arr = [node.value]
    arr += BinarySearchTree.preorder!(node.left) if node.left
    arr += BinarySearchTree.preorder!(node.right) if node.right
    arr
  end

  def self.inorder!(node)
    arr = []
    temp = node
    until node.nil?
      arr << BinarySearchTree.min(node).value
      node = BinarySearchTree.delete_min!(node)
    end
    arr
  end

  def self.postorder!(node)
    return unless node
    arr = []
    arr += BinarySearchTree.postorder!(node.left) if node.left
    arr += BinarySearchTree.postorder!(node.right) if node.right
    arr += [node.value]
    arr
  end

  def self.height!(node)
    return -1 if node.nil?
    left = 1 + BinarySearchTree.height!(node.left)
    right = 1 + BinarySearchTree.height!(node.right)
    return left > right ? left : right
  end

  def self.max(node)
    until node.right.nil?
      node = node.right
    end
    return node
  end

  def self.min(node)
    until node.left.nil?
      node = node.left
    end
    return node
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left
    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node

    if node.value > value
      node.left = BinarySearchTree.delete!(node.left,value)
    elsif node.value < value
      node.right = BinarySearchTree.delete!(node.right,value)
    else
      return node.left unless node.right
      return node.right unless node.left
      node.value = BinarySearchTree.min(node.right)
      node = BinarySearchTree.delete_min!(node.right)
    end
    node
  end
end
