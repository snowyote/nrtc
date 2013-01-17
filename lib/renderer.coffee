module.exports = class Renderer
  constructor: (@elt) ->
    @ctx = @elt.getContext '2d'
    @imgcache = {}

  screenspace: (x, y) ->
    [((x-0.5)*@elt.width)/8, ((y-0.5)*@elt.height)/8]

  boardspace: (x, y) ->
    [x*8/@elt.width + 0.5, y*8/@elt.height + 0.5]

  rect: (x1, y1, x2, y2, style) ->
    @ctx.fillStyle = style
    @ctx.fillRect @screenspace(x1, y1)..., @screenspace(x2, y2)...

  image: (x, y, url) ->
    img = @imgcache[url]
    if img?
      [x, y] = @screenspace(x, y)
      @ctx.drawImage(img, x-(img.width/2), y-(img.height/2))
    else
      elt = document.createElement('img');
      elt.src = url
      # document.body.appendChild elt
      @imgcache[url] = elt

  text: (x, y, str) ->
    @ctx.fillStyle = '#c00'
    @ctx.font = 'italic bold 30px sans-serif'
    @ctx.textBaseline = 'top'
    @ctx.fillText(str, x, y)