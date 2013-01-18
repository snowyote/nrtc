module.exports = class Location
  constructor: (@x, @y) ->
    throw new Error("Location (#{@x},#{@y})? C'mon, son") unless @x? && @y?
  gets: (rhs) ->
    [@x, @y] = [rhs.x, rhs.y]
  move_towards: (other_location, distance) ->
    [dx, dy] = [other_location.x - @x, other_location.y - @y]
    delta = Math.sqrt(dx*dx + dy*dy)
    if delta <= distance
      [@x, @y] = [other_location.x, other_location.y]
      return true
    [@x, @y] = [@x + (distance*dx)/delta, @y + (distance*dy)/delta]
    return false
