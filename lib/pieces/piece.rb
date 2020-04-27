require 'pry'
require 'pry-byebug'
# This class contains things that all pieces need. 
class Piece
  attr_accessor :color, :row, :col
  def initialize(color, row, col)
    @color = color
    @row = row
    @col = col
  end

  def within_bounds?(row, col)
    row.between?(0,7) && col.between?(0,7) ? true : false

  end
  def all_possible_moves(positions)
    possible_moves = []
    moveset.each do |move|
      temp_row = row
      temp_col = col
      loop do
        temp_row += move[0]
        temp_col += move[1]
        break if !within_bounds?(temp_row, temp_col)
        square = positions[temp_row][temp_col]
        # If a square has the same color piece as player he is blocked. 
        if square.color == color
          break
        elsif square.color.nil?
          possible_moves << [temp_row, temp_col]
        else
          possible_moves << [temp_row, temp_col]
          break
        end
      end
    end
    possible_moves
  end
end
