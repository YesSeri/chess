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
    @captured_pieces = []
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

  def game_loop
    loop do
      start_square, finish_square = get_legal_move
      set_new_position(start_square, finish_square)
      @current_player = @current_player == @white_player ? @black_player : @white_player
    end
  end

  def get_legal_move
    start, finish = [], []
    loop do 
      to_s
      start, finish = get_input
      break if legal_move?(self, start, finish) #This is a module dedicated to finding legal moves 
    end
    return start, finish
  end
  
  def get_input
    print "\nstart row"
    row = 7 #gets.chomp.to_i
    p "start col"
    col = 1 #gets.chomp.to_i
    p "finish row"
    finish_row = 4 #gets.chomp.to_i
    p "finish col"
    finish_col = 1 #gets.chomp.to_i
    return [row, col], [finish_row, finish_col]
  end 

  def set_new_position(start, finish)
    if [Rook, King, Pawn].include?(@positions[start[0]][start[1]].class)
      @positions[start[0]][start[1]].has_moved = true
    end
    if !@positions[finish[0]][finish[1]].color.nil? #If piece is capture. (Moving to same color as self is forbidden in legal move check.)
      @captured_pieces << @positions[finish[0]][finish[1]] 
      @positions[finish[0]][finish[1]] = @positions[start[0]][start[1]]
      @positions[start[0]][start[1]] == Empty_Square.new
    else #If you move to empty square, just switch place of empty square and start square. 
      @positions[finish[0]][finish[1]], @positions[start[0]][start[1]] = @positions[start[0]][start[1]], @positions[finish[0]][finish[1]]
    end
  end
  def to_s
    puts 'ROW'
    @positions.each_with_index do |row, i| 
      print "#{i}  "
      row.each do |square|
        print square.symbol
      end
      puts
    end
    print "   "
    for i in 0..7
      print "#{i}  "
    end
    print 'COL'
  end
end
