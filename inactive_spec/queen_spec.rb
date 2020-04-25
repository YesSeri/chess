require 'board'
require 'pieces/queen'

xdescribe 'Queen' do
  let(:board) { Board.new('Henrik', 'Alio') }
  let(:queen) { Queen.new('white', [3, 3]) }

  describe 'movement' do
    it 'can move horizontally' do
      expect(queen.legal_moves).to include([3, 1])
      expect(queen.legal_moves).to include([3, 7])
    end
    it 'can move vertically' do
      expect(queen.legal_moves).to include([0, 3])
      expect(queen.legal_moves).to include([5, 3])
    end
    it 'can move diagonally' do
      expect(queen.legal_moves).to include([5, 5])
      expect(queen.legal_moves).to include([5, 1])
    end
  end
end

