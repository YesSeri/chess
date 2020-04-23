require_relative '../lib/pieces/rook.rb'
describe 'Rook' do
  let(:rook) { Rook.new('white') }

  describe 'move set' do
    it 'can move in all four directions' do
      expect(rook.moveset).to include([0, 1])
      expect(rook.moveset).to include([0, -1])
      expect(rook.moveset).to include([1, 0])
      expect(rook.moveset).to include([-1, 0])
    end
  end
  describe 'possible moves' do
    xit 'can move 3 steps' do
      expect(rook.legal_moves).to include([0, 3])
      expect(rook.legal_moves).to include([3, 0])
    end
  end
end

