require 'rails_helper'

feature 'Combinator' do
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
  end
end
