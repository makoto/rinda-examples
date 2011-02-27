#!/usr/local/bin/ruby

require './drb/drb.rb'

class DRbEx
  def initialize
    @hello = 'hello'
  end

  def hello
    @hello
  end

  def sample(a, b, c)
    a.to_i + b.to_i + c.to_i
  end
end

if __FILE__ == $0
  DRb.start_service('druby://localhost:7640', DRbEx.new)
  DRb.thread.join
end