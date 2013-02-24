DisplayGame = require './lib/displaygame'
Observer    = require './lib/observer'

dg = new DisplayGame(document.getElementById("board"))
game = dg.game

url = require('url').parse(String(window.location), true)
socket = io.connect("#{url.protocol}//#{url.host}/#{url.query.slot_id}")
socket.emit 'auth', url.query.auth

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
socket.on 'init', ({side: color, state: state}) ->
  dg.side = color
  game.restore_from_state state
socket.on 'cancel', (tick, piece_index, cell_index) ->
  game.cancel_move(tick, piece_index, cell_index)
socket.on 'move', (tick, piece, cell) ->
  game.move game.piece_of_index(piece), game.cell_of_index(cell), tick

Observer.observe dg, 'send_move', (piece, cell) ->
  socket.emit 'move', game.current_tick, game.index_of_piece(piece), game.index_of_cell(cell)