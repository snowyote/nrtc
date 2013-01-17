module.exports = class DisplayBoard
  constructor: (@renderer) ->
    @draw()
    
  draw: ->
    for x in [1..8]
      for y in [1..8]
        style = if ((x+y)%2==0) then 'white' else 'black'
        @renderer.rect x-0.5, y-0.5, x+0.5, y+0.5, style
    @renderer.chara 1, 1, '♔'
    @renderer.chara 2, 1, '♔'
    @renderer.chara 1, 2, 'X'
    @renderer.chara 2, 2, 'X'
    