require 'pry'
require 'pry-byebug'
require_relative 'pieces/rook'

require_relative 'pieces/knight.rb'
require_relative 'pieces/bishop.rb'
require_relative 'pieces/queen.rb'
require_relative 'pieces/king'
require_relative 'string'
require_relative 'player'
require_relative 'rules'
include Rules
class Board
  attr_reader :current_player, :positions
  EMPTY_SQUARE = "' "
  
  def initialize
    @white_player = Player.new(:white)
    @black_player = Player.new(:black)
    @current_player = @white_player
    @positions = Array.new(8) { Array.new(8, EMPTY_SQUARE) }
    add_back_rank
    
  end

  def add_back_rank #R0 K1 B2 Q3 $4 B5 K6 R7
    @positions[0][0] = Rook.new(:black)
    @positions[0][7] = Rook.new(:black)
    @positions[0][1] = Knight.new(:black)
    @positions[0][6] = Knight.new(:black)
    @positions[0][2] = Bishop.new(:black)
    @positions[0][5] = Bishop.new(:black)
    @positions[0][3] = Queen.new(:black)
    @positions[0][4] = King.new(:black)
    @positions[7][0] = Rook.new(:white)
    @positions[7][7] = Rook.new(:white)
    @positions[7][1] = Knight.new(:white)
    @positions[7][6] = Knight.new(:white)
    @positions[7][2] = Bishop.new(:white)
    @positions[7][5] = Bishop.new(:white)
    @positions[7][3] = Queen.new(:white)
    @positions[7][4] = King.new(:white)
  end
  def add_pawns

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
      start_square = [row, col]
      p start_square
      p 'to row 6'
      finish_row = 6
      p 'col 0'
      finish_col = [finish_row, finish_col]
      finish_square  = @positions[finish_row][finish_col]
      break if legal_move?(self, start_square, finish_square) #This is a module dedicated to finding legal moves 
      break
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
puts
board.to_s
