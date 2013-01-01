module.exports = class Location
  constructor: (@x, @y) ->
    throw new Error("Location (#{@x},#{@y})? C'mon, son") unless @x? && @y?
