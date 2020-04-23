require 'pry'
#require_relative 'pieces/pawn'
#require_relative 'pieces/bishop'
#require_relative 'pieces/knight'
#require_relative 'pieces/rook'
#require_relative 'pieces/queen'
#require_relative 'pieces/king'
EMPTY_SQUARE ||= "' "
module Rules
  def legal_move?(board, start, finish) #For squares, arrays, first value is row second is column.
    return false if test_range(start, finish) == false
    return false if test_square(board, start, finish) == false
    return false if in_reach?(board, row, col, finish_row, finish_col) == false
  end
  #checks if square is reachable
  def in_reach?(board, row, col, finish_row, finish_col)

  end
  #Used for queen, bishop and rook. Returns all moves in bound. Doesnt notice if piece is in its way. Need to add a check if square is empty here, you can only move through empty squares, never through enemies. You can end up on enemy. 
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
  def test_square(board, start, finish)
    start_piece = board.positions[start[0]][start[1]]
    finish_piece = board.positions[finish[0]][finish[1]]
    return false if start_piece == EMPTY_SQUARE 
    return false if start_piece.color != board.current_player.color
    return false if finish_piece.color == board.current_player.color
  end
  def test_range(start, finish)
    binding.pry
    return false if start == finish
    return false if legal_range?(start) == false
    return false if legal_range?(finish) == false
    true
  end
  def legal_range?(square)
    square.all? { |a| true if a >= 0 && a <= 7 }
  end
end
include Rules
print test_range([0,0], [0,0])