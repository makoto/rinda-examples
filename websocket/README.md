## dRuby WebSocket example

This is a simple example to show how to make websocket server scalable by sharing channel using dRuby.


### Multicast server example without dRuby

- https://github.com/igrigorik/em-websocket/blob/master/examples/multicast.rb


### How to setup

### Add .twitter file at root dir with the following YAML format

    :username: USERNAME
    :password: PASSWORD

### Startup channel server, multiple websocket server, and client pages

    ruby start.rb

### Open up via browser (it will tell you which port number)
