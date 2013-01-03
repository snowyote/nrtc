module.exports = class Move
  constructor: (@from, @to) ->
    throw new Error("Move (#{@from} -> #{@to})? I feel sorry for your mother") unless @from? && @to?
    @valid = @from.valid && @to.valid
