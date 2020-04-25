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
  describe 'class' do
    it 'is rook class' do 
      expect(rook.class).to eq(Rook)
    end
    it 'has symbol' do
      expect(rook.symbol).to be_truthy
    end
  end
end

