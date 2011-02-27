require 'em-websocket'
require 'twitter/json_stream'
require 'json'

#
# broadcast all ruby related tweets to all connected users!
#

username = ARGV.shift
password = ARGV.shift
port = ARGV.shift
raise "need username and password" if !username or !password

EventMachine.run {
  @channel = EM::Channel.new

  @twitter = Twitter::JSONStream.connect(
    :path => '/1/statuses/filter.json?track=a',
    :auth => "#{username}:#{password}"
  )

  @twitter.each_item do |status|
    # status = JSON.parse(status)
    # @channel.push "#{status['user']['screen_name']}: #{status['text']}"
    # p status
    @channel.push status
  end


  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => port.to_i, :debug => true) do |ws|

    ws.onopen {
      sid = @channel.subscribe { |msg| ws.send msg }
      @channel.push "#{sid} connected!"
      ws.onmessage { |msg|
        @channel.push "<#{sid}>: #{msg}"
      }
      ws.onclose {
        @channel.unsubscribe(sid)
      }

    }
  end

  puts "Server started"
}