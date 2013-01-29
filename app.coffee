express = require('express')
app     = express()
server  = require('http').createServer(app)
io      = require('socket.io').listen(server)
Game    = require './lib/game'
Layouts = require './lib/layouts'

server.listen 3000
app.use(express.static(__dirname + '/static'));

game = new Game(Layouts.traditional)
setInterval (-> game.tick()), 66

sides = ['white', 'black']
players = []

for_everyone_but = (me, cb) ->
  for [side, socket] in players when side isnt me
    cb side, socket

for_everyone = (cb) ->
  for [side, socket] in players
    cb side, socket

io.sockets.on 'connection', (socket) ->
  side = sides.shift()
  players.push [side, socket]

  socket.emit 'init',
    side: side
    state: game.states[game.current_tick-1]

  socket.emit 'msg', "Your side is: #{side}"

  socket.on 'move', (tick, piece_index, cell_index) ->
    piece = game.piece_of_index(piece_index)
    cell = game.cell_of_index(cell_index)
    if piece.color == side
      game.move piece, cell, tick
      for_everyone_but side, (_, other_socket) ->
        other_socket.emit 'move', tick, piece_index, cell_index
    else
      for_everyone (side, sock) ->
        sock.emit 'msg', "Filtered #{side}'s illegal move #{piece_index}->#{cell_index}"
        sock.emit 'init',
          side: side
          state: game.states[game.current_tick-1]

  socket.on 'chat', (msg) ->
    for_everyone (_, sock) ->
      sock.emit 'chat', side, msg
