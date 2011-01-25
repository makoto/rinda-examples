require 'drb/drb'

class FactServer
  def initialize(ts)
    @ts = ts
  end

  def main_loop
    loop do
      tuple = @ts.take(['fact', nil, nil])
      m = tuple[1]
      n = tuple[2]
      p tuple
      value = m[]
      p value
      @ts.write(['fact-answer', m, n, value])
    end
  end
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
FactServer.new($ts).main_loop
