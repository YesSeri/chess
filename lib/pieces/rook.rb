require 'pry'
require_relative 'piece.rb'
class Rook < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
    @symbol = color == :white ? 'WR' : 'BR'
  end
end
