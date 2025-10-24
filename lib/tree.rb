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

  def find_recursion (root, key)

    return "not found" if root == nil
    return root if root.value == key

    if root.value > key
      root.left = find_recursion(root.left, key)
    elsif root.value < key
      root.right = find_recursion(root.right, key)
    end


  end

  def find (key)
    return find_recursion(@root,key)
  end

  def pre_order_recursion(root,result)
    return nil if root == nil
    result << root.value
    pre_order_recursion(root.left, result)
    pre_order_recursion(root.right, result)
    return result
  end

  def pre_order
    result = []
    pre_order_recursion(@root, result)
    if block_given?
      result.each {|value| yield value}
    else
      return result
    end
  end

  def in_order_recursion(root,result)
    return nil if root == nil
    in_order_recursion(root.left, result)
    result << root.value
    in_order_recursion(root.right, result)
    return result
  end
  def in_order
    result = []
    in_order_recursion(@root, result)
    if block_given?
      result.each {|value| yield value}
    else
      return result
    end
  end


  def post_order_recursion(root,result)
    return nil if root == nil
    post_order_recursion(root.left, result)
    post_order_recursion(root.right, result)
    result << root.value
    return result
  end
  def post_order
    result = []
    post_order_recursion(@root, result)
    if block_given?
      result.each {|value| yield value}
    else
      return result
    end
  end



  def level_order(root = @root)
    queue = [root]
    result = []

    until queue.empty?
      node = queue.shift

      if block_given?
        yield node.value
      else
        result << node.value
      end
      queue << node.left if node.left
      queue << node.right if node.right

    end
    return result
  end





  def pretty_print(node = @root, prefix = '', is_left = true)

  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left

  end



end