express    = require('express')
app        = express()
server     = require('http').createServer(app)
io         = require('socket.io').listen(server)
GameServer = require('./lib/game_server')
_          = require('underscore')
Q          = require('q')
argv       = require('optimist').argv
database   = require('./lib/database')
ObjectID   = require('mongodb').ObjectID
Config     = require('config').Top
mubsub     = require('mubsub')

start = (db) ->

  port = argv.port || 3000
  server.listen port
  my_url = "http://localhost:#{port}" # @TODO from config or otherwise

  dbu = "mongodb://#{Config.Database.Host}:#{Config.Database.Port}/#{Config.Database.DB}"
  msclient = mubsub(dbu)
  channel = client.channel 'slots_ps'

  app.use(express.static(__dirname + '/static'));

  # clean up existing slots
  # @TODO only by me!
  slots = db.collection("game_slots")
  Q.ninvoke(slots, 'remove', {}).then ->
    # create new slots
    slot_ids = (new ObjectID() for i in [0...Config.NumGames])

    # put em in the db
    slot_promises = for slot_id in slot_ids
      Q.ninvoke slots, 'insert',
        _id: slot_id
        state: 'preparing'
        url: "#{my_url}/#{slot_id.toHexString()}"

    # start up servers for them
    Q.all(slot_promises).then ->
      for slot_id in slot_ids
        console.log "Listening at #{my_url}/index.html?slot_id=#{slot_id.toHexString()}"
        new GameServer(slots, channel, io.of("/#{slot_id.toHexString()}", slot_id))

database.open().then(start).fail((err) -> console.log "ohno. #{err}")
