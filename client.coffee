DisplayGame = require './lib/displaygame'
Observer    = require './lib/observer'
URL         = require 'url'

dg = new DisplayGame(document.getElementById("board"))
game = dg.game

url = URL.parse(window.location)
socket = io.connect("#{url.protocol}//#{url.host}/")
side = null

chat = $("#chat")
$(document).keypress (e) ->
  if e.which == 13
    msg = chat.val()
    console.log "About to chat '#{msg}'"
    socket.emit 'chat', msg
    chat.val('')
    chat.focus()

socket.on 'msg', (msg) -> console.log msg; $("#status").append "<br>#{msg}"
socket.on 'chat', (side, msg) -> $("#status").append "<br>#{side}: '#{msg}'"
socket.on 'side', (color) -> side = color
socket.on 'move', (tick, piece, cell) ->
  game.move game.piece_of_index(piece), game.cell_of_index(cell), tick

Observer.observe dg, 'send_move', (piece, cell) ->
  socket.emit 'move', game.current_tick, game.index_of_piece(piece), game.index_of_cell(cell)