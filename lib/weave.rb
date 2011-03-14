
# Weave a list of arrays together.  Given the lists ["a","b","c"] and ["d","e"], the weave is
#	 [
#	  ["a", "b", "c", "d", "e"],
#	  ["a", "b", "d", "e", "c"],
#	  ["a", "b", "d", "c", "e"],
#	  ["a", "d", "e", "b", "c"],
#	  ["a", "d", "b", "c", "e"],
#	  ["a", "d", "b", "e", "c"],
#	  ["d", "e", "a", "b", "c"],
#	  ["d", "a", "b", "c", "e"],
#	  ["d", "a", "b", "e", "c"],
#	  ["d", "a", "e", "b", "c"]
#	 ] 
# 
# The idea is to produce all the combinations of a set of lists that preserve the original order of the items
# in those lists.  As another example, suppose you have three people doing three tasks ,and want 
# to know all the various ways it could happen.  Assuming persons a,b and c each perform tasks 1 and 2, then you would have
# weave(%w(a1 a2 a3) %w(b1 b2 b3) %w(c1 c2 c3)) answers this result:
#
#	 [
#	  ["a1", "a2", "b1", "b2", "c1", "c2"],
#	  ["a1", "a2", "b1", "c1", "c2", "b2"],
#	  ["a1", "a2", "b1", "c1", "b2", "c2"],
#	  ["a1", "a2", "c1", "c2", "b1", "b2"],
#	  ["a1", "a2", "c1", "b1", "b2", "c2"],
#	  ["a1", "a2", "c1", "b1", "c2", "b2"],
#	  ["a1", "b1", "b2", "a2", "c1", "c2"],
#	  ["a1", "b1", "b2", "c1", "c2", "a2"],
#	  ["a1", "b1", "b2", "c1", "a2", "c2"],
#	  ["a1", "b1", "a2", "b2", "c1", "c2"],
#	  ["a1", "b1", "a2", "c1", "c2", "b2"],
#	  ["a1", "b1", "a2", "c1", "b2", "c2"],
#	  ["a1", "b1", "c1", "c2", "b2", "a2"],
#	  ["a1", "b1", "c1", "c2", "a2", "b2"],
#	  ["a1", "b1", "c1", "b2", "c2", "a2"],
#	  ["a1", "b1", "c1", "b2", "a2", "c2"],
#	  ["a1", "b1", "c1", "a2", "c2", "b2"],
#	  ["a1", "b1", "c1", "a2", "b2", "c2"],
#	  ["a1", "c1", "c2", "a2", "b1", "b2"],
#	  ["a1", "c1", "c2", "b1", "b2", "a2"],
#	  ["a1", "c1", "c2", "b1", "a2", "b2"],
#	  ["a1", "c1", "a2", "c2", "b1", "b2"],
#	  ["a1", "c1", "a2", "b1", "b2", "c2"],
#	  ["a1", "c1", "a2", "b1", "c2", "b2"],
#	  ["a1", "c1", "b1", "b2", "c2", "a2"],
#	  ["a1", "c1", "b1", "b2", "a2", "c2"],
#	  ["a1", "c1", "b1", "c2", "b2", "a2"],
#	  ["a1", "c1", "b1", "c2", "a2", "b2"],
#	  ["a1", "c1", "b1", "a2", "b2", "c2"],
#	  ["a1", "c1", "b1", "a2", "c2", "b2"],
#	  ["b1", "b2", "a1", "a2", "c1", "c2"],
#	  ["b1", "b2", "a1", "c1", "c2", "a2"],
#	  ["b1", "b2", "a1", "c1", "a2", "c2"],
#	  ["b1", "b2", "c1", "c2", "a1", "a2"],
#	  ["b1", "b2", "c1", "a1", "a2", "c2"],
#	  ["b1", "b2", "c1", "a1", "c2", "a2"],
#	  ["b1", "a1", "a2", "b2", "c1", "c2"],
#	  ["b1", "a1", "a2", "c1", "c2", "b2"],
#	  ["b1", "a1", "a2", "c1", "b2", "c2"],
#	  ["b1", "a1", "b2", "a2", "c1", "c2"],
#	  ["b1", "a1", "b2", "c1", "c2", "a2"],
#	  ["b1", "a1", "b2", "c1", "a2", "c2"],
#	  ["b1", "a1", "c1", "c2", "a2", "b2"],
#	  ["b1", "a1", "c1", "c2", "b2", "a2"],
#	  ["b1", "a1", "c1", "a2", "c2", "b2"],
#	  ["b1", "a1", "c1", "a2", "b2", "c2"],
#	  ["b1", "a1", "c1", "b2", "c2", "a2"],
#	  ["b1", "a1", "c1", "b2", "a2", "c2"],
#	  ["b1", "c1", "c2", "b2", "a1", "a2"],
#	  ["b1", "c1", "c2", "a1", "a2", "b2"],
#	  ["b1", "c1", "c2", "a1", "b2", "a2"],
#	  ["b1", "c1", "b2", "c2", "a1", "a2"],
#	  ["b1", "c1", "b2", "a1", "a2", "c2"],
#	  ["b1", "c1", "b2", "a1", "c2", "a2"],
#	  ["b1", "c1", "a1", "a2", "c2", "b2"],
#	  ["b1", "c1", "a1", "a2", "b2", "c2"],
#	  ["b1", "c1", "a1", "c2", "a2", "b2"],
#	  ["b1", "c1", "a1", "c2", "b2", "a2"],
#	  ["b1", "c1", "a1", "b2", "a2", "c2"],
#	  ["b1", "c1", "a1", "b2", "c2", "a2"],
#	  ["c1", "c2", "a1", "a2", "b1", "b2"],
#	  ["c1", "c2", "a1", "b1", "b2", "a2"],
#	  ["c1", "c2", "a1", "b1", "a2", "b2"],
#	  ["c1", "c2", "b1", "b2", "a1", "a2"],
#	  ["c1", "c2", "b1", "a1", "a2", "b2"],
#	  ["c1", "c2", "b1", "a1", "b2", "a2"],
#	  ["c1", "a1", "a2", "c2", "b1", "b2"],
#	  ["c1", "a1", "a2", "b1", "b2", "c2"],
#	  ["c1", "a1", "a2", "b1", "c2", "b2"],
#	  ["c1", "a1", "c2", "a2", "b1", "b2"],
#	  ["c1", "a1", "c2", "b1", "b2", "a2"],
#	  ["c1", "a1", "c2", "b1", "a2", "b2"],
#	  ["c1", "a1", "b1", "b2", "a2", "c2"],
#	  ["c1", "a1", "b1", "b2", "c2", "a2"],
#	  ["c1", "a1", "b1", "a2", "b2", "c2"],
#	  ["c1", "a1", "b1", "a2", "c2", "b2"],
#	  ["c1", "a1", "b1", "c2", "b2", "a2"],
#	  ["c1", "a1", "b1", "c2", "a2", "b2"],
#	  ["c1", "b1", "b2", "c2", "a1", "a2"],
#	  ["c1", "b1", "b2", "a1", "a2", "c2"],
#	  ["c1", "b1", "b2", "a1", "c2", "a2"],
#	  ["c1", "b1", "c2", "b2", "a1", "a2"],
#	  ["c1", "b1", "c2", "a1", "a2", "b2"],
#	  ["c1", "b1", "c2", "a1", "b2", "a2"],
#	  ["c1", "b1", "a1", "a2", "b2", "c2"],
#	  ["c1", "b1", "a1", "a2", "c2", "b2"],
#	  ["c1", "b1", "a1", "b2", "a2", "c2"],
#	  ["c1", "b1", "a1", "b2", "c2", "a2"],
#	  ["c1", "b1", "a1", "c2", "a2", "b2"],
#	  ["c1", "b1", "a1", "c2", "b2", "a2"]
#	 ]
# 
#
# An invariant for weaving is that for any weave of set A and set B,
#
#   weave(A, B) - A = B
#   weave(A, B) - B = A 
#
#  Weave is composable, in that weave(*weave(A,B),C) is not the same as weave(A,B,C) -- try it on a machine with lots
#  of memory if you don't believe me.
  
module Weave
  
  # Answer the weave of all the given sets.  If a block is given, each element of the result is filtered through the block.
  def weave(*sets, &block) 
    return weave_all([],sets,&block)
  end
    
  # Answer the composition of the arrays in sets, given the sequence in prefix, filtered through the block (if given). 
  def weave_all(prefix, sets, &block) 
    ss = sets - [[]]   
    return (if block_given? then [yield(prefix+ss[0]) ] else  [prefix+ss[0]] end) if ss.length==1

    ss.inject([]) { |acc,s|  acc + weave_all(prefix+[s[0]], [s[1..-1]] + ss.reject { |ps| ps == s } , &block ) }
  end 
  
end

 
 







