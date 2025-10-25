require_relative "node.rb"
require_relative "tree.rb"






trial = Tree.new((Array.new(15) { rand(1..100) }))
p trial.balanced?
trial.pretty_print
p trial.level_order
p trial.pre_order
p trial.post_order
p trial.in_order

i = 101
while i > 0
  trial.insert(rand(1..100))
  i -= 1
end
trial.pretty_print
p trial.balanced?
trial.rebalance
p trial.balanced?
trial.pretty_print
