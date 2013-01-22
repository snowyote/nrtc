module.exports = class DisplayBoard
  constructor: (@renderer) ->

  draw: ->
    for x in [1..8]
      for y in [1..8]
        style = if ((x+y)%2==0) then 'white' else 'black'
        @renderer.rect x-0.5, y-0.5, x+0.5, y+0.5, style
