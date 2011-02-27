require 'drb/drb'
require 'nokogiri'
require 'open-uri'

target_url = "http://new-bamboo.co.uk"

def client(ts, target_url)
  ts.write(['proc', target_url, proc { 
    doc = Nokogiri::HTML(open(target_url).read)
    doc.css('title').text 
  }])

  _ , response = ts.take(['proc-answer', nil])
  return response
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
p client($ts, target_url)
