require 'pry'
require 'pry-byebug'
require_relative 'board'
def start_game
  board = Board.new
  game_loop(board)
end
def game_loop(board)
  loop do
    start_square, finish_square = get_legal_move(board)
    board.set_new_position(start_square, finish_square)
    board.current_player = board.current_player == board.white_player ? board.black_player : board.white_player
  end
end
def get_legal_move(board)
  start, finish = [], []
    loop do
      board.to_s
      start, finish = get_input
      if board.legal_move?(self, start, finish) #This is a module dedicated to finding legal moves
        break
      end
    end
    return start, finish
  end
def get_input
  print "\nstart row"
  row = gets.chomp.to_i
  p "start col"
  col = gets.chomp.to_i
  p "finish row"
  finish_row = gets.chomp.to_i
  p "finish col"
  finish_col = gets.chomp.to_i
  return [row, col], [finish_row, finish_col]
end

def save_game
end
def end_game 
end
start_game
