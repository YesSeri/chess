require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'

# Checks for check. Is then used in game file for testing for stalmate and checkmate. 
module Rules
  def in_check?(board)
    king_position = []
    current_color = board.current_player.color
    board.positions.each_with_index do |row, i|
      row.each_with_index do |piece, a|
        if piece.class == King && piece.color == current_color
          print "#{i}   #{a}"
        
          king_position == [i, a]
        end
      end
    end
  end

end


