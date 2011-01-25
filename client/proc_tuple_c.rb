require 'drb/drb'

def proc_client(ts, a, b)
  ts.write(['proc', proc{|num | num * 10}])
  key, request, response = ts.take(['proc-answer', nil, nil])
  return response
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
p proc_client($ts, 1, 5)
