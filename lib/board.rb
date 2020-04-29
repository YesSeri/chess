require 'pry'
require 'pry-byebug'
require 'colorize'
require_relative 'pieces/pieces.rb'
require_relative 'player'
require_relative 'legality'
require_relative 'rules'
include Rules
class Board
  attr_accessor :current_player, :positions, :white_player, :black_player, :captured_pieces

  def initialize
    @white_player = :white
    @black_player = :black
    @current_player = @white_player
    @white_turn = true
    @positions = Array.new(8) { Array.new(8, Empty_Square.new) }
    @captured_pieces = []
    add_back_rank
    add_pawns
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
      @positions[1][i] = Pawn.new(:black, 1, i)
    end
    8.times do |i|
      @positions[6][i] = Pawn.new(:white, 6, i)
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

    if piece.class == Pawn
      return if en_passant_capture(start, finish)
      set_en_passant_pawn(start, finish) 
    else
      Pawn.set_en_passant_pawn(nil)
    end
    
    if !@positions[fin_row][fin_col].color.nil? #If piece is capture. (Moving to same color as self is forbidden in legal move check.)
      @captured_pieces << @positions[fin_row][fin_col]
      @positions[fin_row][fin_col] = @positions[row][col]
      @positions[row][col] = Empty_Square.new

      @positions[fin_row][fin_col].row = fin_row
      @positions[fin_row][fin_col].col = fin_col


    else #If you move to empty square, just switch place of empty square and start square.
      @positions[fin_row][fin_col], @positions[row][col] = @positions[row][col], @positions[fin_row][fin_col]
      @positions[fin_row][fin_col].row = fin_row
      @positions[fin_row][fin_col].col = fin_col
    end
  end
  def en_passant_capture(start, fin)
    if fin == Pawn.en_passant_move_square(@positions[start[0]][start[1]])
      @captured_pieces << @positions[Pawn.get_en_passant_pawn.row][Pawn.get_en_passant_pawn.col] 
      @positions[Pawn.get_en_passant_pawn.row][Pawn.get_en_passant_pawn.col] = Empty_Square.new
      move_square = Pawn.en_passant_move_square(@positions[start[0]][start[1]])
      @positions[move_square[0]][move_square[1]], @positions[start[0]][start[1]] = @positions[start[0]][start[1]], @positions[move_square[0]][move_square[1]] 
      true
    else
      false
    end
  end

  def set_en_passant_pawn(start, finish)
    row = start[0]
    finish_row = finish[0]
    if row - finish_row == 2 || row - finish_row == -2
      Pawn.set_en_passant_pawn(@positions[row][start[1]])
      return true
    end
    if Pawn.get_en_passant_pawn != nil
      Pawn.set_en_passant_pawn(nil) if Pawn.get_en_passant_pawn.color == @current_player
    end
  end

  def castling(start, finish)
    row = finish[0]
    col = finish[1]
    if col == 6
      @positions[row][start[1]].has_moved = true
      @positions[row][7].has_moved = true
      #kingside castle
      @positions[row][6] = @positions[row][4] # This moves king
      @positions[row][4] = @positions[row][5]
      @positions[row][5] = @positions[row][7] # This moves rook
      @positions[row][7] = @positions[row][4]
      @positions[row][5].row = row
      @positions[row][5].col = 5
      @positions[row][6].row = row
      @positions[row][6].col = 6
      true
    elsif col == 2
      @positions[row][start[1]].has_moved = true
      @positions[row][0].has_moved = true
      #queenside castle
      @positions[row][2] = @positions[row][4] # King
      @positions[row][4] = @positions[row][3]
      @positions[row][3] = @positions[row][0] # Rook
      @positions[row][0] = @positions[row][1]
      @positions[row][2].row = row
      @positions[row][2].col = 2
      @positions[row][3].row = row
      @positions[row][3].col = 3
      true
    else
      false
    end
  end
  def find_king(color)
    @positions.flatten.each do |piece|
      return piece if piece.class == King && piece.color == color
    end
  end
  def to_s
    puts
    @positions.each_with_index do |row, i|
      print "#{8-i} "
      color = :yellow if i.even?
      row.each do |square|
        color = color == :yellow ? :light_blue : :yellow
        print "#{square.symbol}".colorize(:background => color)
      end
      puts
    end
    print "   A  B  C  D  E  F  G  H\n"
    white = @captured_pieces.select { |p| p.color == :white }
    black = @captured_pieces.select { |p| p.color == :black }
    puts unless white == []
    white.each { |p| print "#{p.symbol} " }
    puts unless black == []
    black.each { |p| print "#{p.symbol} " }
  end
end
