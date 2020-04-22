require 'pry'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
module Rules
  #Used for queen, bishop and rook. Returns all moves in bound. Doesnt notice if piece is in its way.
  def legal_moves_straight_lines(piece, position)
    row = position[0]
    column = position[1]
    legal_moves = []

    piece.moveset.each do |move|
      temp_row = row
      temp_col = column
      loop do
        temp_row += move[0]
        temp_col += move[1]
        if temp_row.between?(0, 7) && temp_col.between?(0, 7)
          legal_moves << [temp_row, temp_col]
        else
          break
        end
      end
    end
    legal_moves
  end
end
include Rules
rook = Rook.new(:white)
print legal_moves_straight_lines(rook, [3,3])
