module.exports = class Cooldown
  constructor: (@initial, @ticks_remaining=@initial) ->

  tick: ->
    (@ticks_remaining -= 1) <= 0

  fraction_remaining: ->
    Math.max(@ticks_remaining, 0) / @initial
