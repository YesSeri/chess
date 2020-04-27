require_relative 'piece'
class Bishop < Piece
  attr_accessor :moveset, :symbol
  def initialize(color, row, col)
    super(color, row, col)
    @moveset = [
      [1,   1],
      [-1, -1],
      [1,  -1],
      [-1,  1]
    ]
    @symbol = color == :white ? ' WBW ' : ' BBB '
  end
end
b = Bishop.new(:white, 4, 4)
