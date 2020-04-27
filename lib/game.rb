require 'pry'
require 'pry-byebug'
require_relative 'board'
require_relative 'pieces/rook'
require_relative 'rules'
def start_game
  board = Board.new
  game_loop(board)
end
def game_loop(board)
  loop do
    board.to_s
    start_square, finish_square = get_legal_move(board)
    puts
    board.set_new_position(start_square, finish_square)
    binding.pry
    board.current_player = board.current_player == board.white_player ? board.black_player : board.white_player
  end
end
def get_legal_move(board)
  start, finish = [], []
  loop do
    start, finish = get_input
    if board.legal_move?(board, start, finish) #This is a module dedicated to finding legal moves
      temp_board = Marshal.load( Marshal.dump(board)) # Only way to deep copy class.Clone only deep copies on level, not nested arrays.
      temp_board.set_new_position(start, finish)
      in_check?(temp_board)
      break
    end
  end
  return start, finish
end

def get_input
  print "\nstart row"
  row = gets.chomp.to_i
  p "start col"
  col = 7 #gets.chomp.to_i
  p "finish row"
  finish_row = gets.chomp.to_i
  p "finish col"
  finish_col = 7 #gets.chomp.to_i
  return [row, col], [finish_row, finish_col]
end

def save_game
end
def end_game 
end
start_game
