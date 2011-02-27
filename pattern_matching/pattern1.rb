class NotEqual
  def initialize(matcher)
    @matcher = matcher
  end
  def === (other)
    @matcher != other
  end
end

def NE(matcher)
  NotEqual.new(matcher)
end

class MatrixThree
  def ===(other)
    (other.is_a? Array) && other.length == 3  && other.all?{|e| (e.is_a? Array) && e.length == 3}
  end
end

three_by_three_matrix = [[1,2,3],[4,5,6],[7,8,9]]


[1,2,3,"foo", "bar",three_by_three_matrix, 100000].each do |example|
  case example
  when 1 then p "Number one"
  when String then p "String #{example}"
  when (3..1.0/0) then p "Range (bigger than 3) #{example}"
  when MatrixThree.new then p "MatrixThee: #{example.inspect}"
  when NE(1) then p "NotEqual #{example}"
  end
end

foo = proc{|a, b| a + b}
p foo[1,3]