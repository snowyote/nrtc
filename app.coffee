express = require('express')
app     = express()
server  = require('http').createServer(app)
io      = require('socket.io').listen(server)
Game    = require './game'
Layouts = require './layouts'

server.listen 3000
app.use(express.static(__dirname + '/static'));

game = new Game(Layouts.traditional)
setInterval (-> game.tick()), 66

sides = ['white', 'black']
players = []

for_everyone_but = (me, cb) ->
  for [side, socket] in players when side isnt me
    cb side, socket

for_everyone = (side, cb) ->
  for [side, socket] in players
    cb side, socket

io.sockets.on 'connection', (socket) ->
  side = sides.shift()
  players.push [side, socket]

  socket.emit 'init',
    side: side
    tick: game.current_tick
    state: game.states[game.current_tick]

  socket.emit 'msg', "Your side is: #{side}"

  socket.on 'move', (tick, piece, cell) ->
    game.move game.piece_of_index(piece), game.cell_of_index(cell), tick
    for_everyone_but side, (_, other_socket) ->
      other_socket.emit 'move', tick, piece, cell

  socket.on 'chat', (msg) ->
    for_everyone (_, sock) ->
      sock.emit 'chat', side, msg
