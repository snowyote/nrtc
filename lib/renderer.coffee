module.exports = class Renderer
  constructor: (@elt) ->
    @ctx = @elt.getContext '2d'
    @imgcache = {}

  screenspace: (x, y) ->
    [((x-0.5)*@elt.width)/8, ((y-0.5)*@elt.height)/8]

  boardspace: (x, y) ->
    [x*8/@elt.width + 0.5, y*8/@elt.height + 0.5]

  rect: (x1, y1, x2, y2, style, alpha=1.0) ->
    @ctx.globalAlpha = alpha
    @ctx.fillStyle = style
    [ulx, uly] = @screenspace(x1, y1)
    [lrx, lry] = @screenspace(x2, y2)
    @ctx.fillRect ulx, uly, lrx-ulx, lry-uly

  image: (x, y, url, alpha=1.0) ->
    img = @imgcache[url]
    if img?
      [x, y] = @screenspace(x, y)
      @ctx.globalAlpha = alpha
      @ctx.drawImage(img, x-(img.width/2), y-(img.height/2))
    else
      elt = document.createElement('img');
      elt.src = url
      # document.body.appendChild elt
      @imgcache[url] = elt

  text: (x, y, str) ->
    @ctx.globalAlpha = 1.0
    @ctx.fillStyle = '#c00'
    @ctx.font = 'italic bold 30px sans-serif'
    @ctx.textBaseline = 'top'
    @ctx.fillText(str, x, y)