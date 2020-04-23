require_relative '../lib/rules.rb'
require_relative '../lib/board.rb'
# Many things here only works, if there are no pawns in front of back rank. 
describe 'Rules' do
  let(:board) { Board.new }

  describe 'main function' do
    it 'can test if a move is legal' do
      expect(legal_move?(board, [0, 0], [4. 0]).to eq(true) #Move rook 5 steps, only works without pawns. 
      expect(legal_move?(board, [7, 7], [5. 7]).to eq(true) 
    end
  end
  describe 'test_square' do
    it 'start is possible legit, Test that it belongs to correct person, and thereis a piece.' do
      expect(test_start_square(board, [7, 0]).to eq(true)
      expect(test_start_square(board, [4, 3]).to eq(false)
      expect(test_start_square(board, [0, 7]).to eq(false)
    end
  end
end

