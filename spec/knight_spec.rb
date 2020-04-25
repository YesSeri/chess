require_relative '../lib/pieces/pieces.rb'
describe 'Knight' do
  let(:knight) { Knight.new('white') }

  describe 'move set' do
    it 'can move in all four directions' do
      expect(knight.moveset).to include([1, 2])
      expect(knight.moveset).to include([1, -2])
      expect(knight.moveset).to include([2, 1])
      expect(knight.moveset).to include([2, -1])
      expect(knight.moveset).to include([-1, 2])
      expect(knight.moveset).to include([-1, -2])
      expect(knight.moveset).to include([-2, 1])
      expect(knight.moveset).to include([-2, -1])
    end
  end
  describe 'class' do
    it 'is knight class' do 
      expect(knight.class).to eq(Knight)
    end
    it 'has symbol' do
      expect(knight.symbol).to be_truthy
    end
  end
end

