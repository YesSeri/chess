require 'pry'
require 'pry-byebug'
require_relative 'pieces/pieces.rb'
require_relative 'player'
require_relative 'legality'
require_relative 'rules'
include Legality
include Rules
class Board
  attr_accessor :current_player, :positions, :white_player, :black_player, :captured_pieces

  def initialize
    @white_player = Player.new(:white)
    @black_player = Player.new(:black)
    @current_player = @white_player
    @white_turn = true
    @positions = Array.new(8) { Array.new(8, Empty_Square.new) }
    @captured_pieces = []
    add_back_rank
  end

  def add_back_rank
    @positions[0][0] = Rook.  new(:black, 0, 0)
    @positions[0][1] = Knight.new(:black, 0, 1)
    @positions[0][2] = Bishop.new(:black, 0, 2)
    @positions[0][3] = Queen. new(:black, 0, 3)
    @positions[0][4] = King.  new(:black, 0, 4)
    @positions[0][5] = Bishop.new(:black, 0, 5)
    @positions[0][6] = Knight.new(:black, 0, 6)
    @positions[0][7] = Rook.  new(:black, 0, 7)
    @positions[7][0] = Rook.  new(:white, 7, 0)
    @positions[7][1] = Knight.new(:white, 7, 1)
    @positions[7][2] = Bishop.new(:white, 7, 2)
    @positions[7][3] = Queen. new(:white, 7, 3)
    @positions[7][4] = King.  new(:white, 7, 4)
    @positions[7][5] = Bishop.new(:white, 7, 5)
    @positions[7][6] = Knight.new(:white, 7, 6)
    @positions[7][7] = Rook.  new(:white, 7, 7)
  end

  def add_pawns
    8.times do |i|
      @positions[1][i] = Pawn.new(:black)
    end
    8.times do |i|
      @positions[6][i] = Pawn.new(:white)
    end
  end

  def set_new_position(start, finish)
    #Castle?
    row, col = start[0], start[1]
    fin_row, fin_col = finish[0], finish[1]
    piece = @positions[row][col]
    if piece.class == King && !piece.has_moved && [0, 7].include?(fin_row)
      return if castling(start, finish) == true
    end

    if [Pawn, Rook, King].include?(piece.class)
      @positions[row][col].has_moved = true
    end
    if !@positions[fin_row][fin_col].color.nil? #If piece is capture. (Moving to same color as self is forbidden in legal move check.)
      @captured_pieces << @positions[fin_row][fin_col]
      @positions[fin_row][fin_col] = @positions[row][col]
      @positions[row][col] = Empty_Square.new
    else #If you move to empty square, just switch place of empty square and start square.
      @positions[fin_row][fin_col], @positions[row][col] = @positions[row][col], @positions[fin_row][fin_col]
    end
    self
  end
  def castling(start, finish)
    row = finish[0]
    col = finish[1]
    if col == 6
      @positions[row][start[1]].has_moved = true
      @positions[row][7].has_moved = true
      #kingside castle
      @positions[row][6] = @positions[row][4]
      @positions[row][4] = @positions[row][5]
      @positions[row][5] = @positions[row][7]
      @positions[row][7] = @positions[row][4]
      true
    elsif col == 2
      @positions[row][start[1]].has_moved = true
      @positions[row][0].has_moved = true
      #queenside castle
      @positions[row][2] = @positions[row][4]
      @positions[row][4] = @positions[row][3]
      @positions[row][3] = @positions[row][0]
      @positions[row][0] = @positions[row][1]
      true
    else
      false
    end
  end

  def to_s
    puts
    puts 'ROW'
    @positions.each_with_index do |row, i|
      print "#{i}  "
      row.each do |square|
        print square.symbol
      end
      puts
      puts
    end
    print '    '
    for i in 0..7
      print "#{i}    "
    end
    puts 'COL'
    print "#{current_player.color}'s turn"
  end
end
