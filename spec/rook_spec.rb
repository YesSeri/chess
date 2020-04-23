require_relative '../lib/pieces/rook.rb'
describe 'Rook' do
  let(:rook) { Rook.new('white', [0, 0]) }

  describe 'possible moves' do
    it 'can move 3 steps' do
      expect(rook.legal_moves).to include([0, 3])
      expect(rook.legal_moves).to include([3, 0])
    end
  end
end

