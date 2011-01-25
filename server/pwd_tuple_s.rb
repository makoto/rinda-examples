require 'open-uri'


require 'drb/drb'

class ProcServer
  def initialize(ts)
    @ts = ts
  end

  def main_loop
    loop do
      tuple = @ts.take(['proc', nil])
      request = tuple[1]
      response = request[]
      # This returns the location of client, because the object is passed by reference rather than value.
      p response
      @ts.write(['proc-answer', nil, response])
    end
  end
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
ProcServer.new($ts).main_loop
