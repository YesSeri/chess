require 'pry'
require 'pry-byebug'

class Knight
  attr_accessor :coordinates, :possible_moves, :move_list
  def initialize (coordinates)
    @move_list = [
      [ 2, 1],
      [ 2,-1],
      [-2, 1],
      [-2,-1],
      [ 1, 2],
      [ 1,-2],
      [-1, 2],
      [-1,-2],
    ]

    @coordinates = coordinates
    @possible_moves = find_all_possible_moves
end
  def find_all_possible_moves
    possible_moves = []
    @move_list.each do |move|
      x = @coordinates[0] + move[0]
      y = @coordinates[1] + move[1]
      if (0..7) === x
        if (0..7) === y
          possible_moves << [x, y]
        end
      end
    end
    possible_moves
  end
  def to_s
    @possible_moves.each { |a| print a} 
  end
end
