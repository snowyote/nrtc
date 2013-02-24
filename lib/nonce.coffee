set = '123456789bcdfghjklmnpqrstvwxyz'

randomchar = ->
  idx = Math.floor(Math.random()*set.length)
  set.substring(idx, idx+1)

module.exports = ->
  (randomchar() for i in [0...32]).join ''
