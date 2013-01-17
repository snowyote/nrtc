module.exports = class Renderer
  constructor: (@elt) ->
    @ctx = @elt.getContext '2d'

  screenspace: (x, y) ->
    [((x-0.5)*@elt.width)/8, ((y-0.5)*@elt.height)/8]

  rect: (x1, y1, x2, y2, style) ->
    @ctx.fillStyle = style
    @ctx.fillRect @screenspace(x1, y1)..., @screenspace(x2, y2)...
