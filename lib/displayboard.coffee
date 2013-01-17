module.exports = class DisplayBoard
  constructor: (@elt) ->
    @ctx = @elt.getContext '2d'
    @draw()
    
  screenspace: (x, y) ->
    [((x-0.5)*@elt.width)/8, ((y-0.5)*@elt.height)/8]

  draw: ->
    for x in [1..8]
      for y in [1..8]
        style = if ((x+y)%2==0) then 'white' else 'black'
        @ctx.fillStyle = style
        @ctx.fillRect @screenspace(x-0.5, y-0.5)..., @screenspace(x+0.5, y+0.5)...
        