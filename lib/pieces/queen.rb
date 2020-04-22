require 'pry'
require_relative 'piece.rb'
class Queen < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
    @symbol = color == :white ? 'WQ' : 'BQ'
  end
end
