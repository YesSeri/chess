require_relative 'piece'
class King < Piece
  attr_accessor :symbol, :moveset, :has_moved
  def initialize(color, row, col)
    super(color, row, col)
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

