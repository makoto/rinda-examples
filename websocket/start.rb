require 'webrick'
require 'yaml'
config = YAML.load_file('./config.yml')

servers  = config[:server][:port]
clients  = config[:client][:port]
channel  = config[:channel][:port]

include WEBrick

p servers
p clients
p channel

pids = []

## channel server
pid = fork do
  p "starting up channel server at port #{channel}"
  exec "ruby channel.rb #{channel}"
end
pids << pid

## websocket server
servers.each do |server|
  pid = fork do
    p "starting up websocket server at port #{server}"
    exec "ruby server.rb #{server} #{channel}"
  end
  pids << pid
end

## client html page pointing to ws server
clients.zip(servers) do |client, server|
  pid = fork do
    p "starting up client page at port #{client} which points to websocket server #{server}"
    p "Open up http://localhost:#{client} on your browser"
    exec "ruby client.rb #{server} -p #{client}"
  end
  pids << pid
end
p "Server pids are #{pids.join(" ")}"


Process.wait