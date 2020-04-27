require 'pry'
require 'pry-byebug'
require_relative 'piece'
require_relative 'empty_square'
class Pawn < Piece
  attr_accessor :symbol, :has_moved
  def initialize(color, row, col)
    super(color, row, col)
    @symbol = color == :white ? ' WPW ' : ' BPB '
    @moveset = color == :white ? [[-1, 0]] : [[1, 0]]
    @has_moved = false
    @first_moveset = color == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, -0]]
  end
  def moveset
    if @has_moved
      @moveset
    else
      @first_moveset
    end
  end
 def all_possible_moves(positions)
    possible_moves = pawn_legal_captures(positions)
    moveset.each do |move|
      possible_moves << [row+move[0], col]
    end
    possible_moves
  end

  def pawn_legal_captures(positions)
    opposite_color = color == :white ? :black : :white
    i = color == :white ? -1 : 1
    legal_captures = []
    left_capture = positions[row + i][col - 1]
    right_capture =  positions[row + i][col + 1]
    left_capture ||= Empty_Square.new
    right_capture ||= Empty_Square.new
    legal_captures << [row + i, col - 1] if left_capture.color == opposite_color
    legal_captures << [row + i, col + 1] if right_capture.color == opposite_color
    legal_captures
  end
end
