require 'rubygems'
require 'em-websocket'
require 'drb'
require 'twitter/json_stream'

username = ARGV.shift
password = ARGV.shift
port = ARGV.shift # eg: 22345
begin
start = Time.now  

@channel = EM::Channel.new
DRb.start_service("druby://localhost:#{port}", @channel)

EventMachine.run{
  @twitter = Twitter::JSONStream.connect(
    :path => '/1/statuses/filter.json?track=a',
    :auth => "#{username}:#{password}"
  )

  @twitter.each_item do |status|
    @channel.push status
  end    
}

rescue Exception => e
  p "start: #{start} end:#{Time.now}"
  p e
  raise
end
