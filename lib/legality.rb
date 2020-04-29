require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'

module Legality
  def legal_move?(board, start, finish) 
    return false if start_square_legal?(board, start) == false
    return false if in_moveset_and_unblocked?(board, start, finish) == false
    true
  end

  def in_moveset_and_unblocked?(board, start, finish)
    piece = board.positions[start[0]][start[1]]
    possible_moves = piece.all_possible_moves(board.positions)
    return true if possible_moves.include?(finish)
    false
  end
  
  
  def start_square_legal?(board, start)
    start_piece = board.positions[start[0]][start[1]]
    return false if start_piece.color != board.current_player
    true
  end
end
