require_relative 'piece.rb'
class King < Piece
  attr_accessor :symbol, :moveset
  def initialize(color)
    super(color)
    @moveset = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]]
    @symbol = color == :white ? 'W$ ' : 'B$ '
    @has_moved = false
  end
end
