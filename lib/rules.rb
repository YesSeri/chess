require 'pry'
#require_relative 'pieces/pawn'
#require_relative 'pieces/bishop'
#require_relative 'pieces/knight'
#require_relative 'pieces/rook'
#require_relative 'pieces/queen'
#require_relative 'pieces/king'
EMPTY_SQUARE ||= "' "
module Rules
  def legal_move?(board, row, col, finish_row,) #For squares, arrays, first value is row second is column.
    return false if test_range(row, col, finish_row, finish_col) == false
    start_square_piece = board.positions[row][col]
    finish_square_piece = board.positions[row][col]
    return false if test_square(start_square_piece, finish_square_piece) == false
  end

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
  def test_square(start_square_piece, finish_square_piece)
    return false if start_square_piece == EMPTY_SQUARE 
    return false if start_square_piece.color != board.current_player.color
    return false if finish_square_piece.color == board.current_player.color
  end
  def test_range(row, col, finish_row, finish_col)
    start_square, finish_square = [row, col], [finish_row, finish_col]
    return false if legal_range?(start_square) == false
    return false if legal_range?(finish_square) == false
  end
  def legal_range?(square)
    square.all? { |a| true if a >= 0 && a <= 7 }
  end
end
include Rules
