require 'pry'
require 'pry-byebug'
require_relative 'pieces/rook'
require_relative 'string'
require_relative 'player'

class Board
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
      p 'to row 6'
      finish_row = 6
      p 'col 0'
      finish_col = 0
      break if legal_move?(@positions[row][col], @positions[row][col], @current_player) 
      break
    end
    @positions[finish_row][finish_col] = @positions[col][row]
    @positions[col][row] = EMPTY_SQUARE
  end
  def legal_move?(start_square, finish_square)
    start_legal = start_square != EMPTY_SQUARE && start_square.color == @current_player.color 
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
board.to_s
rook = Rook.new(:white)
print Rook.ancestors
print "abc".symbol
board.make_move
board.to_s
