require 'open-uri'
require 'nokogiri'

require 'drb/drb'

class ProcServer
  def initialize(ts)
    @ts = ts
  end

  def main_loop
    loop do
      tuple = @ts.take(['proc', nil, nil])
      _, target_url, query = tuple
      p "url: #{target_url}, query: #{query}"
      response = query[]
      @ts.write(['proc-answer', response])
    end
  end
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
ProcServer.new($ts).main_loop
