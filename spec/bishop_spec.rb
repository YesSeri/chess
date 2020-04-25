require_relative '../lib/pieces/pieces.rb'
describe 'Bishop' do
  let(:bishop) { Bishop.new('white') }

  describe 'move set' do
    it 'can move in all four directions' do
      expect(bishop.moveset).to include([1, 1])
      expect(bishop.moveset).to include([-1, -1])
      expect(bishop.moveset).to include([1, -1])
      expect(bishop.moveset).to include([-1, 1])
    end
  end

  describe 'class' do
    it 'is bishop class' do 
      expect(bishop.class).to eq(Bishop)
    end
    it 'has symbol' do
      expect(bishop.symbol).to be_truthy
    end
  end
end

