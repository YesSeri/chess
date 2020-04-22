require 'pry'
require 'pry-byebug'
require_relative 'pieces/rook'
require_relative 'string'
require_relative 'player'
require_relative 'pieces/rules'
include Rules
class Board
  attr_reader :current_player, :positions
  EMPTY_SQUARE = "' "
  
  def initialize
    @white_player = Player.new(:white)
    @black_player = Player.new(:black)
    @current_player = @white_player
    @positions = Array.new(8) { Array.new(8, EMPTY_SQUARE) }
    @positions[0][0] = Rook.new(:black)
    @positions[0][7] = Rook.new(:black)
    @positions[7][0] = Rook.new(:white)
    @positions[7][7] = Rook.new(:white)
  end

  #Was used for to_s, but created String method symbol instead so I can use same for both pieces and strings. Maybe this one is unneccessary?

  def contains_piece?(square)
    return true if square.class.ancestors.include? Piece
  end 

  def make_move
    p 'make move'
    to = [0, 6]
    row, col, finish_row, finish_col = 0

    loop do 
      
      p 'from row 0'
      row = 0 
      p 'col 0'
      col = 0 
      start_square = @positions[row][col]
      p 'to row 6'
      finish_row = 6
      p 'col 0'
      finish_col = 0
      finish_square  = @positions[finish_row][finish_col]
      break if legal_move?(self, start_square, finish_square) 
  end
    @positions[finish_row][finish_col] = @positions[col][row]
    @positions[col][row] = EMPTY_SQUARE
  end
  def to_s
    @positions.each do |row| 
      row.each do |square|
        print square.symbol
      end
      puts
    end
  end
end
board = Board.new
board.make_move
