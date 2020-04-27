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
    positions[row][col].moveset.each do |move|
      possible_moves << [row+move[0], col]
    end
    possible_moves
  end

  def pawn_legal_captures(positions)
    opposite_color = color == :white ? :black : :white
    legal_captures = []
    if color == :white
      left_capture_piece = positions[row - 1][col - 1]
      right_capture_piece =  positions[row - 1][col + 1]
      legal_captures << [row - 1, col - 1] if left_capture_piece.color == opposite_color
      legal_captures << [row - 1, col + 1] if right_capture_piece.color == opposite_color
    else
      left_capture_piece = positions[row + 1][col - 1]
      right_capture_piece =  positions[row + 1][col + 1]
      legal_captures << [row + 1, col - 1] if left_capture_piece.color == opposite_color
      legal_captures << [row + 1, col + 1] if right_capture_piece.color == opposite_color
    end
    legal_captures
  end
end
board = Array.new(8) { Array.new(8, Empty_Square.new) }
pawn = Pawn.new(:white, 4, 4)
