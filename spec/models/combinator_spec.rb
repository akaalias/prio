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

  context '.generate_comparisons' do
    context 'given there are no tasks' do
      it 'returns an empty list' do
        result = Combinator.generate_comparisons
        expect(result.size).to be(0)
      end
    end

    context 'given there is one task' do
      before :each do
        @a = Task.create(description: "A")
      end
      it 'returns an empty list' do
        result = Combinator.generate_comparisons
        expect(result.size).to be(0)
      end
    end

    context 'given there are two tasks' do
      before :each do
        @a = Task.create(description: "A")
        @b = Task.create(description: "B")
      end

      it 'generates one comparison' do
        result = Combinator.generate_comparisons

        expect(result.size).to be(1)
      end
      it 'is a comparison of A and b' do
        result = Combinator.generate_comparisons

        expect(result[0].task_left_id).to be(@a.id)
        expect(result[0].task_right_id).to be(@b.id)
      end
    end

    context 'given there are three tasks' do
      before :each do
        @a = Task.create(description: "A")
        @b = Task.create(description: "B")
        @c = Task.create(description: "C")
      end

      it 'generates 3 comparisons' do
        result = Combinator.generate_comparisons

        expect(result.size).to be(3)
      end

      it 'is a comparison of A - B, A - C and B - C' do
        result = Combinator.generate_comparisons

        expect(result[0].task_left_id).to eq(@a.id)
        expect(result[0].task_right_id).to eq(@b.id)

        expect(result[1].task_left_id).to eq(@a.id)
        expect(result[1].task_right_id).to eq(@c.id)

        expect(result[2].task_left_id).to eq(@b.id)
        expect(result[2].task_right_id).to eq(@c.id)
      end
    end
  end
end
