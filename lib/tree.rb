class Tree

  attr_accessor :array , :initial, :last , :root

  def initialize(unique_array)
    @array = unique_array.uniq.sort
  end

  def build_tree_recrusive(array, initial , last)


    return nil if initial > last

    mid = initial + (last- initial) / 2

    root = Node.new(array[mid])

    root.left = build_tree_recrusive(array, initial, mid - 1)
    root.right = build_tree_recrusive(array, mid+1, last)

    return root

  end

  def build_tree
    return @root = build_tree_recrusive(@array, 0 , @array.length - 1)
  end

  def insert_recursion (root, key)

    return Node.new(key) if root == nil

    if key < root.value
      root.left = insert_recursion(root.left, key)
    else
      root.right = insert_recursion(root.right, key)
    end

    return root
  end

  def insert (key)
    return @root = insert_recursion(@root, key)
  end

  def get_successor (curr)
    curr = curr.right
    while (curr != nil && curr.left != nil)
      curr = curr.left
    end
    return curr
  end

  def delete_recursion (root, x)
    return root if root == nil

    if root.value > x
      root.left = delete_recursion(root.left,x)
    elsif root.value < x
      root.right = delete_recursion(root.right,x)
    else
      return root.right if root.left == nil
      return root.left if root.right == nil

      succ = get_successor(root)
      root.value = succ.value
      root.right = delete_recursion(root.right, succ.value)
    end

    return root
  end

  def delete (key)
    return @root = delete_recursion(@root, key)
  end



  def pretty_print(node = @root, prefix = '', is_left = true)

  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left

  end



end