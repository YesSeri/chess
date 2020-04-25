require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'
module Rules
  def legal_move?(board, start, finish) #For squares, arrays, first value is row second is column.
    return false if test_range(start, finish) == false
    return false if start_square_legal?(board, start) == false
    return false if finish_square_legal?(board, finish) == false
    return false if pawn_capture_legal?(board, start, finish) == false
    return false if piece_blocking?(board, start, finish) == true
    true
  end

  #checks if square is reachable
  #Different for different pieces. One for straight movers, one for knight and so on. 

  def piece_blocking?(board, start, finish)
    piece = board.positions[start[0]][start[1]]
    if piece.class == Knight || King #Knight jumps over, cant be blocked. King can always take. Control for check happens later. 
      return true
    elsif piece.class == Queen || Rook || Bishop
      all_legal = long_move_all_legal(board, start, finish)
    elsif piece.class == Pawn
    end
    true
  end
  def pawn_capture_legal?(board, start, finish)
  
  end
  #Used for queen, bishop and rook. Returns all moves in bound. Doesnt notice if piece is in its way. Need to add a check if square is empty here, you can only move through empty squares, never through enemies. You can end up on enemy. 
  #Returns all legal moves, and stops when blocked.
  def long_move_all_legal(board, start, finish)
    piece = board.positions[start[0]][start[1]]
    empty_square = Empty_Square.new
    row = start[0]
    column = start[1]
    legal_moves = []
    piece.moveset.each do |move|
      temp_row = row
      temp_col = column
      loop do
        temp_row += move[0]
        temp_col += move[1]
        break if !temp_row.between?(0, 7) || !temp_col.between?(0, 7)
        # If a square has the same color piece as player he is blocked. 
        if board.positions[temp_row][temp_col].color == board.current_player.color
          break
        elsif board.positions[temp_row][temp_col].color == empty_square.color 
          legal_moves << [temp_row, temp_col]
        else
          legal_moves << [temp_row, temp_col]
          break
        end
      end
    end
    legal_moves
  end
  
  def start_square_legal?(board, start)
    start_piece = board.positions[start[0]][start[1]]
    return false if start_piece.color != board.current_player.color
    true
  end

  def finish_square_legal?(board, finish)
    finish_piece = board.positions[finish[0]][finish[1]]
    return false if finish_piece.color == board.current_player.color
    true
  end

  def test_range(start, finish)
    return false if start == finish
    return false if legal_range?(start) == false
    return false if legal_range?(finish) == false
    true
  end

  def legal_range?(square)
    square.all? { |a| true if a >= 0 && a <= 7 }
  end
end
