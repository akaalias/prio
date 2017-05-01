require 'rails_helper'

feature 'Comparison' do
  describe '.next_pending_comparison' do
    context 'when there are no tasks' do
      it 'returns nil' do
        result = Comparison.next_pending_comparison

        expect(result).to eq(nil)
      end
    end

    context 'when there is one pending comparison' do
      it 'returns that comparison' do
        @t1 = Task.create(description: "Task A")
        @t2 = Task.create(description: "Task B")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t1.id)
        expect(result.task_right_id).to eq(@t2.id)
      end
    end

    context 'when there is no pending comparison' do
      it 'returns that comparison' do
        @t1 = Task.create(description: "Task A")
        @t2 = Task.create(description: "Task B")

        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id)

        result = Comparison.next_pending_comparison

        expect(result).to eq(nil)
      end
    end

    context 'when the choices are made one by one' do
      it 'returns different comparisons' do

        @t1 = Task.create(description: "Task A")
        @t2 = Task.create(description: "Task B")
        @t3 = Task.create(description: "Task C")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t1.id)
        expect(result.task_right_id).to eq(@t2.id)

        # user makes first choice
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id)

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t1.id)
        expect(result.task_right_id).to eq(@t3.id)

        # user makes second choice
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t1.id)

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t2.id)
        expect(result.task_right_id).to eq(@t3.id)

        # user makes third choice
        @comparison = Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t2.id)

        result = Comparison.next_pending_comparison

        expect(result).to eq(nil)
      end
    end
  end
end
