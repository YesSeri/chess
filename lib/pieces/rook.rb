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
  def legal_moves(position)
    row = position[0]
    column = position[1]
    legal_moves = []
    
    moveset.each do |move|
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
rook = Rook.new(:white)
p rook.legal_moves([3,3])
