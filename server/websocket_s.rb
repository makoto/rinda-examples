require 'em-websocket'

port = ARGV[0].to_i
p port
EventMachine.run {
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => port) do |ws|
        ws.onopen {
          puts "WebSocket connection open"

          # publish message to the client
          ws.send "Hello Client"
        }

        ws.onclose { puts "Connection closed" }
        ws.onmessage { |msg|
          puts "Recieved message: #{msg}"
          ws.send "Pong: #{msg}"
        }
    end
}