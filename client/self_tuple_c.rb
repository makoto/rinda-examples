require 'drb/drb'

target_url = "http://new-bamboo.co.uk"
# p target_url
# open(url).read

module Egg

  def self.client(ts, url)
    p url
    me = self
    ts.write(['proc', proc{  [self, me] }])
    key, request, response = ts.take(['proc-answer', nil, nil])
    return response
  end

end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
p Egg.client($ts, target_url)
