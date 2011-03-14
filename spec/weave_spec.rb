require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include Weave
describe "Weave Class" do 
  before(:all) do
      @set1 = %w(a b c)
      @set2 = %w(d e f) 
      @set3 = %w(a b)
      @set4 = %w(c d)
      @set5 = %w(e f)
      @result_of_weave_of_a_b_c_and_d_e_f = [
          ["a", "b", "c", "d", "e", "f"], 
          ["a", "b", "d", "e", "f", "c"], 
          ["a", "b", "d", "e", "c", "f"], 
          ["a", "b", "d", "c", "e", "f"], 
          ["a", "d", "e", "f", "b", "c"], 
          ["a", "d", "e", "b", "c", "f"], 
          ["a", "d", "e", "b", "f", "c"], 
          ["a", "d", "b", "c", "e", "f"], 
          ["a", "d", "b", "e", "f", "c"], 
          ["a", "d", "b", "e", "c", "f"], 
          ["d", "e", "f", "a", "b", "c"], 
          ["d", "e", "a", "b", "c", "f"], 
          ["d", "e", "a", "b", "f", "c"], 
          ["d", "e", "a", "f", "b", "c"], 
          ["d", "a", "b", "c", "e", "f"], 
          ["d", "a", "b", "e", "f", "c"], 
          ["d", "a", "b", "e", "c", "f"], 
          ["d", "a", "e", "f", "b", "c"], 
          ["d", "a", "e", "b", "c", "f"], 
          ["d", "a", "e", "b", "f", "c"]
          ]
      @three_way_weave_result = [
           ["a", "b", "c", "d", "e", "f"],
           ["a", "b", "c", "e", "f", "d"],
           ["a", "b", "c", "e", "d", "f"],
           ["a", "b", "e", "f", "c", "d"],
           ["a", "b", "e", "c", "d", "f"],
           ["a", "b", "e", "c", "f", "d"],
           ["a", "c", "d", "b", "e", "f"],
           ["a", "c", "d", "e", "f", "b"],
           ["a", "c", "d", "e", "b", "f"],
           ["a", "c", "b", "d", "e", "f"],
           ["a", "c", "b", "e", "f", "d"],
           ["a", "c", "b", "e", "d", "f"],
           ["a", "c", "e", "f", "d", "b"],
           ["a", "c", "e", "f", "b", "d"],
           ["a", "c", "e", "d", "f", "b"],
           ["a", "c", "e", "d", "b", "f"],
           ["a", "c", "e", "b", "f", "d"],
           ["a", "c", "e", "b", "d", "f"],
           ["a", "e", "f", "b", "c", "d"],
           ["a", "e", "f", "c", "d", "b"],
           ["a", "e", "f", "c", "b", "d"],
           ["a", "e", "b", "f", "c", "d"],
           ["a", "e", "b", "c", "d", "f"],
           ["a", "e", "b", "c", "f", "d"],
           ["a", "e", "c", "d", "f", "b"],
           ["a", "e", "c", "d", "b", "f"],
           ["a", "e", "c", "f", "d", "b"],
           ["a", "e", "c", "f", "b", "d"],
           ["a", "e", "c", "b", "d", "f"],
           ["a", "e", "c", "b", "f", "d"],
           ["c", "d", "a", "b", "e", "f"],
           ["c", "d", "a", "e", "f", "b"],
           ["c", "d", "a", "e", "b", "f"],
           ["c", "d", "e", "f", "a", "b"],
           ["c", "d", "e", "a", "b", "f"],
           ["c", "d", "e", "a", "f", "b"],
           ["c", "a", "b", "d", "e", "f"],
           ["c", "a", "b", "e", "f", "d"],
           ["c", "a", "b", "e", "d", "f"],
           ["c", "a", "d", "b", "e", "f"],
           ["c", "a", "d", "e", "f", "b"],
           ["c", "a", "d", "e", "b", "f"],
           ["c", "a", "e", "f", "b", "d"],
           ["c", "a", "e", "f", "d", "b"],
           ["c", "a", "e", "b", "f", "d"],
           ["c", "a", "e", "b", "d", "f"],
           ["c", "a", "e", "d", "f", "b"],
           ["c", "a", "e", "d", "b", "f"],
           ["c", "e", "f", "d", "a", "b"],
           ["c", "e", "f", "a", "b", "d"],
           ["c", "e", "f", "a", "d", "b"],
           ["c", "e", "d", "f", "a", "b"],
           ["c", "e", "d", "a", "b", "f"],
           ["c", "e", "d", "a", "f", "b"],
           ["c", "e", "a", "b", "f", "d"],
           ["c", "e", "a", "b", "d", "f"],
           ["c", "e", "a", "f", "b", "d"],
           ["c", "e", "a", "f", "d", "b"],
           ["c", "e", "a", "d", "b", "f"],
           ["c", "e", "a", "d", "f", "b"],
           ["e", "f", "a", "b", "c", "d"],
           ["e", "f", "a", "c", "d", "b"],
           ["e", "f", "a", "c", "b", "d"],
           ["e", "f", "c", "d", "a", "b"],
           ["e", "f", "c", "a", "b", "d"],
           ["e", "f", "c", "a", "d", "b"],
           ["e", "a", "b", "f", "c", "d"],
           ["e", "a", "b", "c", "d", "f"],
           ["e", "a", "b", "c", "f", "d"],
           ["e", "a", "f", "b", "c", "d"],
           ["e", "a", "f", "c", "d", "b"],
           ["e", "a", "f", "c", "b", "d"],
           ["e", "a", "c", "d", "b", "f"],
           ["e", "a", "c", "d", "f", "b"],
           ["e", "a", "c", "b", "d", "f"],
           ["e", "a", "c", "b", "f", "d"],
           ["e", "a", "c", "f", "d", "b"],
           ["e", "a", "c", "f", "b", "d"],
           ["e", "c", "d", "f", "a", "b"],
           ["e", "c", "d", "a", "b", "f"],
           ["e", "c", "d", "a", "f", "b"],
           ["e", "c", "f", "d", "a", "b"],
           ["e", "c", "f", "a", "b", "d"],
           ["e", "c", "f", "a", "d", "b"],
           ["e", "c", "a", "b", "d", "f"],
           ["e", "c", "a", "b", "f", "d"],
           ["e", "c", "a", "d", "b", "f"],
           ["e", "c", "a", "d", "f", "b"],
           ["e", "c", "a", "f", "b", "d"],
           ["e", "c", "a", "f", "d", "b"]]  
     @four_sets_weave_sorted = [
            ["a", "b", "c", "d"],
            ["a", "b", "d", "c"],
            ["a", "c", "b", "d"],
            ["a", "c", "d", "b"],
            ["a", "d", "b", "c"],
            ["a", "d", "c", "b"],
            ["b", "a", "c", "d"],
            ["b", "a", "d", "c"],
            ["b", "c", "a", "d"],
            ["b", "c", "d", "a"],
            ["b", "d", "a", "c"],
            ["b", "d", "c", "a"],
            ["c", "a", "b", "d"],
            ["c", "a", "d", "b"],
            ["c", "b", "a", "d"],
            ["c", "b", "d", "a"],
            ["c", "d", "a", "b"],
            ["c", "d", "b", "a"],
            ["d", "a", "b", "c"],
            ["d", "a", "c", "b"],
            ["d", "b", "a", "c"],
            ["d", "b", "c", "a"],
            ["d", "c", "a", "b"],
            ["d", "c", "b", "a"]]
  end 
  
  it "should answer an empty array when given no inputs" do
     result = weave()
     result.should == []
  end
  
  it "should answer an array with the sole argument as a member when there is just one argument" do
     result = weave(@set1) 
     result.should == [@set1]
  end 
  
  it "should answer the non-empty array when passed an non-empty array and an empty array" do
     result = weave(@set1,[])
     result.should == [@set1]
  end 
  
  it "should answer the non-empty array when passed an empty array and a non-empty array" do
     result = weave([],@set1)
     result.should == [@set1]
  end  
  
  it "should take two arrays with a single element and answer an array containing two arrays with the elements in each order" do
     result = weave(%w(a), %w(b)) 
     result.should == [%w(a b), %w(b a)]
  end 
  
  it "should properly weave the sets [a b c] and [d e f]" do
    result = weave(@set1, @set2)
    result.should == @result_of_weave_of_a_b_c_and_d_e_f
  end
  
  it "should always be that for any element E in the weave(A,B), E - A == B" do
    the_weave = weave(@set1,@set2)
    the_weave.each { |e| (e - @set1).should == @set2 && (e - @set2).should == @set1 }
  end
  
  it "should weave more than two sets properly" do
    result = weave @set3, @set4, @set5
    result.should == @three_way_weave_result
  end 
  
  it "should handle more than three sets" do 
      result = weave(%w(a),%w(b),%w(c),%w(d)).sort
      result.should == @four_sets_weave_sorted
  end
  
  it "should be the same as the array.permutation(4) method results for single-element arguments" do 
    if [].respond_to? :permutation then
      result = weave(%w(a),%w(b),%w(c),%w(d)).sort - ["a","b","c","d"].permutation(4).to_a.sort
      result.should == []  
  else
      pending "Waiting to convert to rpsec2  once and for all"
    end
    
  end
end
