# This class contains things that all pieces need. 

class Piece
  attr_accessor :color
  def initialize(color)
    @color = color
  end
end

class Pawn < Piece
  attr_accessor :symbol, :has_moved, :moveset
  def initialize(color)
    super(color)
    @symbol = color == :white ? 'WP ' : 'BP '
    @moveset = color == :white ? [1, 0] : [-1, 0]
    @has_moved = false
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
    @symbol = color == :white ? 'WK ' : 'BK '
  end
end

class Bishop < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
    @symbol = color == :white ? 'WB ' : 'BB '
  end
end

class Rook < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
    @symbol = color == :white ? 'WR ' : 'BR '
    @has_moved = false
  end
end

class Queen < Piece
  attr_accessor :moveset, :symbol
  def initialize(color)
    super(color)
    @moveset = [
      [0,  1],
      [0, -1],
      [1,  0],
      [-1, 0],
      [1,  1],
      [-1,-1],
      [1, -1],
      [-1, 1]
    ]
    @symbol = color == :white ? 'WQ ' : 'BQ '
  end
end

class King < Piece
  attr_accessor :symbol, :moveset
  def initialize(color)
    super(color)
    @moveset = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]]
    @symbol = color == :white ? 'W$ ' : 'B$ '
    @has_moved = false
  end
end

