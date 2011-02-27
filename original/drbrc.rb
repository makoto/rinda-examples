
#!/usr/local/bin/ruby

require './drb/drb.rb'

class DRbEx2
  def initialize(n)
    @n = n
  end

  def _dump
    raise TypeError, 'can\'t dump'
  end

  def to_i
    @n.to_i
  end
end

if __FILE__ == $0
  DRb.start_service('druby://localhost:7950')
  ro = DRbObject.new(nil, 'druby://localhost:7640')
  p ro.hello
  p ro.sample(DRbEx2.new(1), 2, 3)
  p ro.sample(1, ro.sample(DRbEx2.new(1), 2, 3), DRbEx2.new(3))
end