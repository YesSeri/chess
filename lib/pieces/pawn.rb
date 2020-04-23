require_relative 'piece.rb'
class Pawn < Piece
  def initialize
    super(color)
    @symbol = color == :white ? 'WP' : 'BP'
    @move_set = color == :white ? [1, 0] : [-1, 0]
    @has_moved = false
  end
end

