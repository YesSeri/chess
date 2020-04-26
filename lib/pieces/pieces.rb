# This class contains things that all pieces need. 

class Piece
  attr_accessor :color, :symbol
  def initialize(color)
    @color = color
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
end


