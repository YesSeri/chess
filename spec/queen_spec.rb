require_relative '../lib/pieces/queen.rb'
describe 'Queen' do
  let(:queen) { Queen.new('white') }

  describe 'move set' do
    it 'can move in all four directions' do
      expect(queen.moveset).to include([0, 1])
      expect(queen.moveset).to include([0, -1])
      expect(queen.moveset).to include([1, 0])
      expect(queen.moveset).to include([-1, 0])
      expect(queen.moveset).to include([1, 1])
      expect(queen.moveset).to include([-1, -1])
      expect(queen.moveset).to include([1, -1])
      expect(queen.moveset).to include([-1, 1])
    end
  end
  describe 'class' do
    it 'is queen class' do 
      expect(queen.class).to eq(Queen)
    end
    it 'has symbol' do
      expect(queen.symbol).to be_truthy
    end
  end
end

