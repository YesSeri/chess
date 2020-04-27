require_relative '../lib/pieces/bishop.rb'
require_relative '../lib/board'

describe 'Bishop' do
  let(:bishop) { Bishop.new('white', 4, 4) }
  let(:board) { Board.new }

  
  describe 'move set' do
    it 'can move in all four directions' do
      expect(bishop.moveset).to include([1, 1])
      expect(bishop.moveset).to include([-1, -1])
      expect(bishop.moveset).to include([1, -1])
      expect(bishop.moveset).to include([-1, 1])
    end
  end
  describe 'all possible moves' do
    it 'gets legal moves only' do
      expect(bishop.all_possible_moves).to include([5, 5])
      expect(bishop.all_possible_moves).to include([2, 2])
      expect(bishop.all_possible_moves).to include([3, 5])
      expect(bishop.all_possible_moves).to include([2, 6])
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

