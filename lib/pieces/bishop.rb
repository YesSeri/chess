require 'pry'
require_relative 'piece.rb'
class Bishop < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
    @symbol = color == :white ? 'WR' : 'BR'

  end
end
