require_relative 'piece'
class Knight < Piece
  attr_accessor :moveset, :symbol
  def initialize(color, row, col)
    super(color, row, col)
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
      move_row, move_col = row + move[0], col + move[1]
      if Board.within_bounds?(move_row, move_col)
        possible_moves << [(move_row, move_col)]
      end
    end
    possible_moves
  end
end

