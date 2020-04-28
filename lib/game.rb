require 'pry'
require 'pry-byebug'
require 'yaml'
require_relative 'board'
require_relative 'pieces/rook'
require_relative 'rules'
include Legality
def start_game
  print 'Do you want to load board?'
  if gets.chomp[0].upcase == 'Y'
    board = load_game
  else
    board = Board.new
  end
  game_loop(board)
end
def game_loop(board)
  loop do
    board.to_s
    string = board.stalemate_or_checkmate(board)

    unless string == 'continue'
      puts string
      break
    end
    start_square, finish_square = [], []
    loop do
      start_square, finish_square = get_moves
      save_game(board) if [start_square, finish_square].flatten.include?('save')
      break if legit_move?(board, start_square, finish_square)
      print 'illegal move, try again'
    end
    puts
    board.set_new_position(start_square, finish_square)
    board.current_player = board.current_player == board.white_player ? board.black_player : board.white_player
  end
end
def legit_move?(board, start, finish)
  if board.legal_move?(board, start, finish) #This is a module dedicated to finding legal moves
  temp_board = Marshal.load( Marshal.dump(board)) # Only way to deep copy class.Clone only deep copies on level, not nested arrays.
  temp_board.set_new_position(start, finish)
    if !in_check?(temp_board)
      return true
    end
  end
  false
end

def get_moves
  print "\nstart row"
  row = gets.chomp
  p "start col"
  col = gets.chomp
  p "finish row"
  finish_row = gets.chomp
  p "finish col"
  finish_col = gets.chomp
  translate_input(row, col, finish_row, finish_col)
end
def translate_input(row, col, finish_row, finish_col)
  binding.pry
  return [row, col], [finish_row, finish_col] if [row, col, finish_row, finish_col].include?('save')
  return [row.to_i, col.to_i], [finish_row.to_i, finish_col.to_i] 
end
def save_game(board)
  File.open("../save/chess_save.yml", "w") {|f| f.write(board.to_yaml)}
  exit
end

def load_game
  board = begin
    YAML.load(File.open("../save/chess_save.yml"))
  rescue ArgumentError => e
    puts "Could not parse YAML: #{e.message}"
  end
  board
end

start_game
