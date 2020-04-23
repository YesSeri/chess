require_relative 'piece.rb'
class King
  def initialize
    @symbol = color == :white ? 'W$' : 'B$'
  end
end
