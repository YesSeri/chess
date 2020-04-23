require_relative 'piece.rb'
class Pawn < Piece
  def initialize
    @symbol = color == :white ? 'WP' : 'BP'
  end
end

