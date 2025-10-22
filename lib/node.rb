class Node
  attr_accessor :value, :left , :right

  include Comparable

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end