require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'
require_relative 'string'
require_relative 'player'
require_relative 'rules'
include Rules
class Board
  attr_reader :current_player, :positions
  
  def initialize
    @white_player = Player.new(:white)
    @black_player = Player.new(:black)
    @current_player = @white_player
    @positions = Array.new(8) { Array.new(8, Empty_Square.new) }
    add_back_rank
    
  end

  def add_back_rank
    @positions[0][0] = Rook.  new(@black_player.color)
    @positions[0][7] = Rook.  new(@black_player.color)
    @positions[0][1] = Knight.new(@black_player.color)
    @positions[0][6] = Knight.new(@black_player.color)
    @positions[0][2] = Bishop.new(@black_player.color)
    @positions[0][5] = Bishop.new(@black_player.color)
    @positions[0][3] = Queen. new(@black_player.color)
    @positions[0][4] = King.  new(@black_player.color)
    @positions[7][0] = Rook.  new(@white_player.color)
    @positions[7][7] = Rook.  new(@white_player.color)
    @positions[7][1] = Knight.new(@white_player.color)
    @positions[7][6] = Knight.new(@white_player.color)
    @positions[7][2] = Bishop.new(@white_player.color)
    @positions[7][5] = Bishop.new(@white_player.color)
    @positions[7][3] = Queen. new(@white_player.color)
    @positions[7][4] = King.  new(@white_player.color)
  end
  def add_pawns
    8.times do |i|
      @positions[1][i] = Pawn.new(:black)
    end
    8.times do |i|
      @positions[6][i] = Pawn.new(:white)
    end
  end

  def make_move
    row, col, finish_row, finish_col = 0

    loop do 
      start, finish = [], []
      row = 7 
      col = 7 
      start.push(row, col) 
      p start
      finish_row = 2
      finish_col = 7 
      finish.push(finish_row, finish_col) 
      p finish
      #break if legal_move?(self, start, finish) #This is a module dedicated to finding legal moves 
      break
  end
    @positions[finish_row][finish_col] = @positions[col][row]
    @positions[col][row] = Empty_Square.new
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
print long_move_all_legal(board, [7, 3], [2, 0])
