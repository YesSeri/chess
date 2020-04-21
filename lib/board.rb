require 'pry'
require 'pry-byebug'
require_relative 'knight.rb'

class Board
  EMPTY_SQUARE = " "
  
  def initialize
    @positions = Array.new(8) { Array.new(8, EMPTY_SQUARE) }
    @pieces = { :white_knight => 'k'}
  end
  
  def to_s
    @positions.each do |a| 
      print "|"
      a.each {|b| print "#{b}|" }
      puts
    end
  end
  def add_knight
    @knight = Knight.new(coordinates) # Standard coords
    @positions[@knight.x_coordinate][@knight.y_coordinate] = @pieces[:white_knight]
  end
  def move_knight
  end
end
