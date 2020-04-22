require 'board'
require 'pieces/bishop'

describe 'Bishop' do
  let(:board) { Board.new('Henrik', 'Alio') }
  let(:bishop) { Bishop.new('white', [0, 0]) }

  describe 'possible moves' do
    it 'can move diagonally' do
      expect(bishop.legal_moves).to include([5, 5])
      expect(bishop.legal_moves).to include([5, 1])
    end
  end
end

