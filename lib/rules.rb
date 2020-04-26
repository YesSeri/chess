require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'
module Rules
  def legal_move?(board, start, finish) #For squares, arrays, first value is row second is column.
    return false if test_range(start, finish) == false
    return false if start_square_legal?(board, start) == false
    return false if finish_square_legal?(board, finish) == false
    return false if in_moveset_and_unblocked?(board, start, finish) == false
    true
  end

  #checks if square is reachable
  #Different for different pieces. One for straight movers, one for knight and so on. 

  def in_moveset_and_unblocked?(board, start, finish)
    
    piece = board.positions[start[0]][start[1]]

    if piece.class == Knight #Knight jumps over, cant be blocked. King can always take. Control for check happens later. 
      possible_moves = all_knight_moves(piece, start)
      return true if possible_moves.include?(finish)
    elsif piece.class == Queen || piece.class == Rook || piece.class == Bishop
      possible_moves = legal_long_moves(board, start)
      return true if possible_moves.include?(finish)
    elsif piece.class == Pawn
      possible_moves = pawn_legal_moves(board, start)
      return true if possible_moves.include?(finish)
    elsif piece.class == King 
      possible_moves = all_king_moves(board, piece, start)
      return true if possible_moves.include?(finish)
    end
    false
  end
  def all_king_moves(board, king, start)
    possible_moves = []
    possible_moves << castling_king_side_test(board, king, start)
    possible_moves << castling_queen_side_test(board, king, start)
    king.moveset.each do |move|
      possible_moves << [start[0] + move[0], start[1] + move[1]]
    end
    possible_moves
  end
  def castling_king_side_test(board, king, start)

      binding.pry
    i = board.current_player.color == :white ? 7 : 0
    return if board.positions[i][7].class != Rook || board.positions[i][7].color != board.current_player.color
    if !king.has_moved && !board.positions[i][7].has_moved && board.positions[i][6].class == Empty_Square && board.positions[i][5].class == Empty_Square
      return [i, 6]
    end    
  []
  end
  def castling_queen_side_test(board, king, start)
    i = board.current_player.color == :white ? 7 : 0
    return if board.positions[i][0].class != Rook || board.positions[i][7].color != board.current_player.color
    if !king.has_moved && !board.positions[i][0].has_moved && board.positions[i][1].class == Empty_Square && board.positions[i][2].class == Empty_Square && board.positions[i][3].class == Empty_Square
      return [i, 2]
    end    
  end
  def all_knight_moves(knight, start)
    possible_moves = []
    knight.moveset.each do |move, i|
      possible_moves << [(start[0] + move[0]), (start[1] + move[1])]
    end
    possible_moves
  end

  def pawn_legal_moves(board, start)
    possible_moves = pawn_legal_captures(board, start)
    board.positions[start[0]][start[1]].moveset.each do |move|
      possible_moves << [start[0]+move[0], start[1]]
    end
    possible_moves

  end
  def pawn_legal_captures(board, start)
    opposite_color = board.current_player.color == :white ? :black : :white
    legal_captures = []
    row = start[0]
    col = start[1] 
    if board.current_player.color == :white
      left_capture_piece = board.positions[row - 1][col - 1]
      right_capture_piece =  board.positions[row - 1][col + 1]
      legal_captures << [row -1, col - 1] if left_capture_piece.color == opposite_color
      legal_captures << [row -1, col + 1] if right_capture_piece.color == opposite_color
    else
      left_capture_piece = board.positions[row + 1][col - 1]
      right_capture_piece =  board.positions[row + 1][col + 1]
      legal_captures << [row + 1, col - 1] if left_capture_piece.color == opposite_color
      legal_captures << [row + 1, col + 1] if right_capture_piece.color == opposite_color
    end
    legal_captures
  end
  #Used for queen, bishop and rook. Returns all moves in bound. Doesnt notice if piece is in its way. Need to add a check if square is empty here, you can only move through empty squares, never through enemies. You can end up on enemy. 
  #Returns all legal moves, and stops when blocked.
  def legal_long_moves(board, start)
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
