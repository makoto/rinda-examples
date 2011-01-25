require 'rinda/tuplespace'
three_by_three_matrix = [[1,2,3],[4,5,6],[7,8,9]]
two_by_three_matrix = [[1,2],[4,5],[7,8]]
random_list = [[1,2,3],[4],[7,8]]
random_list2 = [[1,2,3],[7,8]]

tuple = Rinda::TupleSpace.new
[three_by_three_matrix, two_by_three_matrix, random_list, random_list2].each do |example|
  tuple.write(example)
end

# Can't do nested pattern matches
tuple.read([[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]], 0)

class Length
  def initialize(size)
    @size = size
  end
  def === (other)
    other.size == @size
  end
end

tuple.read([Length.new(3)] * 3, 0)

