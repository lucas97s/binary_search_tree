class Tree

  attr_accessor :array , :initial, :last , :root

  def initialize(unique_array)
    @array = unique_array.uniq.sort
    self.build_tree
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
    @root = insert_recursion(@root, key)
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

  def depth_recursive(root, key, dist = 0 )
    return nil if root == nil

    #check for condition
    if root.value == key
      return dist
    elsif root.value < key
      dist += 1
      depth_recursive(root.right, key, dist)
    elsif root.value > key
      dist += 1
      depth_recursive(root.left, key, dist)
    end

  end

  def depth(key)
    return depth_recursive(@root,key )
  end

  def height_recursive(root,key,dist)
    return 0 if root == nil
    left_height = height_recursive(root.left,key,dist)
    right_height = height_recursive(root.right,key,dist)

    result = [left_height,right_height].max + 1
    if root.value == key
      dist[0] = result - 1
    end
    return result
  end

  def height(key)
    dist = []
    height_recursive(@root, key,dist)
    return dist[0]
  end

  def balanced_recursive(root,key,result)
    return 0 if root == nil
    store_left_right_values = []
      store_left_right_values[0] = balanced_recursive(root.left,key,result)[0] + 1
      store_left_right_values[1] = balanced_recursive(root.right,key,result)[1] + 1
      difference = store_left_right_values[1] - store_left_right_values[0]

    if root.value == key

      result[0] = difference.abs
    end
    return store_left_right_values
  end

  def balanced?
    self.level_order do |key|
      result = []
      balanced_recursive(@root,key,result)
      p "Printing the values #{result[0]}"
      if result[0] > 1
        p "Printing the values #{result[0]}"
        return false
      end
    end
    return true

  end

  def rebalance
    @array = self.level_order.uniq.sort
    @root = self.build_tree
  end





  def pretty_print(node = @root, prefix = '', is_left = true)

  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left

  end



end