# Example from jijixi.azito.com/cgi-bin/diary/index.rb?date=20070108
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

three_by_three_matrix = [[1,2,3],[4,5,6],[7,8,9]]
two_by_three_matrix = [[1,2],[4,5],[7,8]]
random_list = [[1,2,3],[4],[7,8]]
random_list2 = [[1,2,3],[7,8]]

def three_by_three?(example)
  return false unless example.size == 3
  example.each do |row|
    return false unless row.size == 3
  end
end

[three_by_three_matrix, two_by_three_matrix, random_list, random_list2].each do |example|
  # if three_by_three?(example)
  if example.all?{|e| e.length == 3} && example.length == 3
    p "#{example.inspect} is 3 by 3"
  else
    p "#{example.inspect} no match"
  end
end


