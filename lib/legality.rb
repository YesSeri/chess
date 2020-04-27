require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'
module Legality
  def legal_move?(board, start, finish) #For squares, arrays, first value is row second is column.
    return false if start_square_legal?(board, start) == false
    return false if in_moveset_and_unblocked?(board, start, finish) == false
    true
  end

  #checks if square is reachable
  #Different for different pieces. One for straight movers, one for knight and so on. 

  def in_moveset_and_unblocked?(board, start, finish)
    piece = board.positions[start[0]][start[1]]
    possible_moves = piece.all_possible_moves(board.positions)
    return true if possible_moves.include?(finish)
    false
  end
  
  
  #Used for queen, bishop and rook. Returns all moves in bound. Doesnt notice if piece is in its way. Need to add a check if square is empty here, you can only move through empty squares, never through enemies. You can end up on enemy. 
  #Returns all legal moves, and stops when blocked.
    def start_square_legal?(board, start)
    start_piece = board.positions[start[0]][start[1]]
    return false if start_piece.color != board.current_player.color
    true
  end
end
