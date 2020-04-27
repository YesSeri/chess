require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'

# Checks for check. Is then used in game file for testing for stalmate and checkmate. 
# The board recieved is one where the new move is already applied. If current player is in check here that means he is in check after making move which means it is illegal.
module Rules
  def in_check?(board)
    king = find_king(board.current_player.color)
    board.positions.flatten { |p| !p.class != Empty_Square && p.color != king.color }.each do |piece|
      if piece.all_possible_moves.include?([king.row, king.col])
        return true
      end
    end
    false
  end
end


