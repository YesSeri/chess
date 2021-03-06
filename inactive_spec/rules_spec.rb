require_relative '../lib/rules.rb'
require_relative '../lib/board.rb'

# Many things here only works, if there are no pawns in front of back rank. 
describe Rules do
include Rules
  let(:board) { Board.new }
  describe 'main rules function' do
    it 'can test if a move is legal' do
      expect(legal_move?(board, [7, 1], [5, 2])).to be true #knight
      expect(legal_move?(board, [7, 6], [6, 4])).to be true  
      expect(legal_move?(board, [7, 1], [2, 2])).to be false
      expect(legal_move?(board, [6, 1], [5, 1])).to be true
      expect(legal_move?(board, [6, 4], [4, 4])).to be true
    end
  end
  describe 'is the start square legal' do
    it 'contains current player piece' do
      expect(start_square_legal?(board, [7, 0])).to be true #White starts
      expect(start_square_legal?(board, [7, 1])).to be true #White starts
      expect(start_square_legal?(board, [7, 2])).to be true #White starts
      expect(start_square_legal?(board, [7, 3])).to be true #White starts
      expect(start_square_legal?(board, [7, 4])).to be true #White starts
      expect(start_square_legal?(board, [7, 5])).to be true #White starts
      expect(start_square_legal?(board, [7, 6])).to be true #White starts
      expect(start_square_legal?(board, [7, 7])).to be true #White starts
      expect(start_square_legal?(board, [4, 3])).to be false
      expect(start_square_legal?(board, [0, 7])).to be false
    end
  end
  describe 'end square' do
    it 'tests if square is legal' do
      expect(finish_square_legal?(board, [4, 0])).to be true #Empty square
      expect(finish_square_legal?(board, [7, 0])).to be false #White square, white turn
      expect(finish_square_legal?(board, [0, 7])).to be true #Black square, white turn
    end
  end
end

