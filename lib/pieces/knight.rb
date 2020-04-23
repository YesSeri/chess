require 'pry'
require 'pry-byebug'
require_relative 'piece.rb'
class Knight < Piece
  attr_accessor :moveset, :symbol
  def initialize (color)
    super(color)
    @moveset = [
      [ 2, 1],
      [ 2,-1],
      [-2, 1],
      [-2,-1],
      [ 1, 2],
      [ 1,-2],
      [-1, 2],
      [-1,-2],
    ]
    @symbol = color == :white ? 'WK' : 'BK'
  end
end
