require 'drb/drb'

class FactServer
  def initialize(ts)
    @ts = ts
  end

  def main_loop
    loop do
      tuple = @ts.take(['fact', nil])
      request = tuple[1]
      p tuple
      response = request[]
      p response
      @ts.write(['fact-answer', nil, response])
    end
  end
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
FactServer.new($ts).main_loop
