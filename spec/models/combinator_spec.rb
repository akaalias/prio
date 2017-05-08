require 'rails_helper'

feature 'Combinator' do

  describe '.unique_combinations' do
    context 'input list is empty' do
      it 'returns an empty list' do
        result = Combinator.unique_combinations([])
        expect(result).to eq([])
      end
    end

    context 'input list only has one element' do
      it 'returns an empty list' do
        result = Combinator.unique_combinations([1])
        expect(result).to eq([])
      end
    end

    context 'input list only has two elements' do
      it 'returns a list with combination a' do
        result = Combinator.unique_combinations([1, 2])
        expect(result).to eq([[1,2]])
      end

      it 'returns a list with combination b' do
        result = Combinator.unique_combinations([:foo, :bar])
        expect(result).to eq([[:foo, :bar]])
      end
    end

    context 'input list only has three elements' do
      it 'returns a list with 3 combinations' do
        result = Combinator.unique_combinations([1, 2, 3])
        expect(result).to eq([[1, 2], [1, 3], [2, 3]])
      end
    end

    context 'input list only has four elements' do
      it 'returns a list with 6 combinations' do
        result = Combinator.unique_combinations([1, 2, 3, 4])
        expect(result).to eq([[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]])
      end
    end

    context 'input list only has five elements' do
      it 'returns a list with 10 combinations' do
        result = Combinator.unique_combinations([1, 2, 3, 4, 5])
        expect(result).to eq([[1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [3, 5], [4, 5]])
      end
    end
  end
end
