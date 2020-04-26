# This class contains things that all pieces need. 
require_relative '../board'
class Piece
  attr_accessor :color
  def initialize(color, row, col)
    @color = color
    @row = row
    @col = col
  end
  def all_possible_moves(positions)
    possible_moves = []
    piece.moveset.each do |move|
      temp_row = row
      temp_col = col
      loop do
        temp_row += move[0]
        temp_col += move[1]
        break if !temp_row.between?(0, 7) || !temp_col.between?(0, 7)
        # If a square has the same color piece as player he is blocked. 
        if positions[temp_row][temp_col].color == color
          break
        elsif positions[temp_row][temp_col].color == empty_square.color
          possible_moves << [temp_row, temp_col]
        else
          possible_moves << [temp_row, temp_col]
          break
        end
      end
    end
    possible_moves
  end
end
class Empty_Square
  attr_accessor :color, :symbol
  def initialize
    @color = nil
    @symbol = ' ... '
  end
end

class Pawn < Piece
  attr_accessor :symbol, :has_moved
  def initialize(color)
    super(color)
    @symbol = color == :white ? ' WPW ' : ' BPB '
    @moveset = color == :white ? [[-1, 0]] : [[1, 0]]
    @has_moved = false
    @first_moveset = color == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, -0]]
  end
  def moveset
    if @has_moved
      @moveset
    else
      @first_moveset
    end
  end
 def pawn_legal_moves(positions)
    possible_moves = pawn_legal_captures(positions)
    positions[row][col].moveset.each do |move|
      possible_moves << [row+move[0], col]
    end
    possible_moves
  end

  def pawn_legal_captures(positions)
    opposite_color = color == :white ? :black : :white
    legal_captures = []
    if color == :white
      left_capture_piece = positions[row - 1][col - 1]
      right_capture_piece =  positions[row - 1][col + 1]
      legal_captures << [row -1, col - 1] if left_capture_piece.color == opposite_color
      legal_captures << [row -1, col + 1] if right_capture_piece.color == opposite_color
    else
      left_capture_piece = positions[row + 1][col - 1]
      right_capture_piece =  positions[row + 1][col + 1]
      legal_captures << [row + 1, col - 1] if left_capture_piece.color == opposite_color
      legal_captures << [row + 1, col + 1] if right_capture_piece.color == opposite_color
    end
    legal_captures
  end
end

class Knight < Piece
  attr_accessor :moveset, :symbol
  def initialize (color)
    super(color)
    @moveset = [
      [ 2, 1],
      [ 2,-1],
      [-2, 1],
      [-2,-1],
      [ 1, 2],
      [ 1,-2],
      [-1, 2],
      [-1,-2],
    ]
    @symbol = color == :white ? ' WKW ' : ' BKB '
  end
  def all_possible_moves()
    possible_moves = []
    moveset.each do |move|
      if Board.within_bounds?(row + move[0], col + move[1])
        possible_moves << [(row + move[0]), (col + move[1])]
      end
    end
    possible_moves
  end
end

class Bishop < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [1,   1],
      [-1, -1],
      [1,  -1],
      [-1,  1]
    ]
    @symbol = color == :white ? ' WBW ' : ' BBB '
  end
end

class Rook < Piece
  attr_accessor :moveset, :symbol, :has_moved
  def initialize(color)
    super(color)
    @moveset = [
      [0,  1],
      [0, -1],
      [1,  0],
      [-1, 0]
    ]
    @symbol = color == :white ? ' WRW ' : ' BRB '
    @has_moved = false
  end
end

class Queen < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]]
    @symbol = color == :white ? ' WQW ' : ' BQB '
  end
end

class King < Piece
  attr_accessor :symbol, :moveset, :has_moved
  def initialize(color)
    super(color)
    @moveset = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]]
    @symbol = color == :white ? ' W$W ' : ' B$B '
    @has_moved = false
  end
  def all_possible_moves(positions)
    possible_moves = []
    possible_moves << castling_king_side_test(positions)
    possible_moves << castling_queen_side_test(positions)
    moveset.each do |move|
      if Board.within_bounds?(row + move[0], col + move[1])
        possible_moves << [row + move[0], col + move[1]] 
      end
    end
    possible_moves
  end
  def castling_king_side_test(positions)
    i = color == :white ? 7 : 0
    return if positions[i][7].class != Rook || positions[i][7].color != color
    if !has_moved && !positions[i][7].has_moved && positions[i][6].class == Empty_Square && positions[i][5].class == Empty_Square
      return [i, 6]
    end    
  []
  end
  def castling_queen_side_test(positions)
    i = color == :white ? 7 : 0
    return if positions[i][0].class != Rook || positions[i][7].color != color 
    if !king.has_moved && !positions[i][0].has_moved && positions[i][1].class == Empty_Square && positions[i][2].class == Empty_Square && positions[i][3].class == Empty_Square
      return [i, 2]
    end    
  end
end


