require 'drb/drb'

target_url = "http://new-bamboo.co.uk"

def client(ts, target_url)
  ts.write(['proc', target_url, proc{|doc| doc.css('title').text }] )
  _ , response = ts.take(['proc-answer', nil])
  return response
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
p client($ts, target_url)
