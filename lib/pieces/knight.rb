require 'pry'
require 'pry-byebug'
require_relative 'piece.rb'
class Knight < Piece
  attr_accessor :coordinates, :possible_moves, :move_list
  def initialize (color)
    super(color)
    @move_list = [
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
  
  def to_s
    @possible_moves.each { |a| print a} 
  end
end
