require 'drb/drb'
require 'nokogiri'
require 'open-uri'

target_url = "http://new-bamboo.co.uk"

class Handler
  def initialize(target_url)
    @target_url = target_url
  end
  
  def run
    doc = Nokogiri::HTML(open(target_url).read)
    doc.css('title').text 
  end
end

handler = Handler.new(target_url)

def client(ts, target_url)
  ts.write(['crawl', handler)]

  _ , response = ts.take(['crawl-answer', nil])
  return response
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
p client($ts, target_url)
