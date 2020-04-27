# This class contains things that all pieces need. 
class Piece
  attr_accessor :color, :row, :col
  def initialize(color, row, col)
    @color = color
    @row = row
    @col = col
  end
  def all_possible_moves(positions)
    possible_moves = []
    piece.moveset.each do |move|
      temp_row = row
      temp_col = col
      loop do
        temp_row += move[0]
        temp_col += move[1]
        break if !temp_row.between?(0, 7) || !temp_col.between?(0, 7)
        # If a square has the same color piece as player he is blocked. 
        if positions[temp_row][temp_col].color == color
          break
        elsif positions[temp_row][temp_col].color == empty_square.color
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
