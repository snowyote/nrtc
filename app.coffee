express = require('express')
app     = express()
server  = require('http').createServer(app)
io      = require('socket.io').listen(server)

server.listen 3000
app.use(express.static(__dirname + '/static'));

sides = ['white', 'black']
players = []

io.sockets.on 'connection', (socket) ->
  side = sides.shift()
  socket.emit 'side', side
  socket.emit 'msg', "Your side is: #{side}"
  players.push [side, socket]
  socket.on 'move', (tick, piece, cell) ->
    for [other_side, other_socket] in players when other_side isnt side
      other_socket.emit 'move', tick, piece, cell
