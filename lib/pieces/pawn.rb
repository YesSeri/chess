require_relative 'piece.rb'
class Pawn < Piece
  attr_accessor :symbol, :has_moved, :moveset
  def initialize(color)
    super(color)
    @symbol = color == :white ? 'WP ' : 'BP '
    @moveset = color == :white ? [1, 0] : [-1, 0]
    @has_moved = false
  end
end

