require 'em-websocket'
require 'twitter/json_stream'
require 'json'
require 'drb'

#
# broadcast all ruby related tweets to all connected users!
#

ws_port = ARGV.shift.to_i # eg: 12345 and 12346
channel_port = ARGV.shift.to_i # 22345
DRb.start_service
@channel = DRbObject.new_with_uri("druby://localhost:#{channel_port}")

EventMachine.run {
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => ws_port, :debug => true) do |ws|

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
