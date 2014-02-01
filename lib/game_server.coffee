Game    = require './game'
Layouts = require './layouts'
_       = require 'underscore'

module.exports = class GameServer
  constructor: (slots, channel, root_socket, slot_id) ->
    channel.subscribe {slot: slot_id}, (doc) =>
      console.log "burf: #{doc}"

    slots.findOne {_id: slot_id}, (err, slot) ->
      game = new Game(Layouts.traditional)
      setInterval (-> game.tick()), 66

      observers = 0
      sides = ['white', 'black']
      players = []

      for_everyone_but = (me, cb) ->
        for [side, socket] in players when side isnt me
          cb side, socket

      for_everyone = (cb) ->
        for [side, socket] in players
          cb side, socket

      root_socket.on 'connection', (socket) ->
        side = sides.shift() or "Observer #{observers += 1}"
        players.push [side, socket]

        socket.emit 'init',
          side: side
          state: game.states[game.current_tick-1]

        socket.emit 'msg', "Your side is: #{side}"

        socket.on 'move', (tick, piece_index, cell_index) ->
          piece = game.piece_of_index(piece_index)
          cell = game.cell_of_index(cell_index)
          if piece? && cell? && piece.color == side
            game.move piece, cell, tick
            for_everyone_but side, (_, other_socket) ->
              other_socket.emit 'move', tick, piece_index, cell_index
          else
            for_everyone (_side, _sock) ->
              _sock.emit 'msg', "Filtered #{side}'s illegal move #{piece_index}->#{cell_index}"
            socket.emit 'cancel', tick, piece_index, cell_index

        socket.on 'chat', (msg) ->
          for_everyone (_, sock) ->
            sock.emit 'chat', side, msg

        socket.on 'disconnect', ->
          sides.push side
          players = _.reject players, ([_side, _]) -> _side == side
