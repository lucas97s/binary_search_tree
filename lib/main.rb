require_relative "node.rb"
require_relative "tree.rb"






trial = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
trial.build_tree
trial.insert(111)
trial.pretty_print
