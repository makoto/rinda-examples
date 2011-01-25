require 'drb/drb'

target_url = "http://new-bamboo.co.uk"
# p target_url
# open(url).read


def client(ts, url)
  p url
  ts.write(['proc', proc{  `pwd`  }])
  key, request, response = ts.take(['proc-answer', nil, nil])
  return response
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
p client($ts, target_url)
