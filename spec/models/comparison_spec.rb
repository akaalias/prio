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

        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id, measure: "important")
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id, measure: "urgent")

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
        expect(result.measure).to eq("important")

        # measuring urgency
        # user makes first choice
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id, measure: "important")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t1.id)
        expect(result.task_right_id).to eq(@t3.id)
        expect(result.measure).to eq("important")

        # user makes second choice
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t1.id, measure: "important")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t2.id)
        expect(result.task_right_id).to eq(@t3.id)
        expect(result.measure).to eq("important")

        # user makes third choice
        @comparison = Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t2.id, measure: "important")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t1.id)
        expect(result.task_right_id).to eq(@t2.id)
        expect(result.measure).to eq("urgent")

        # measuring importance
        # user makes first choice
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id, measure: "urgent")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t1.id)
        expect(result.task_right_id).to eq(@t3.id)
        expect(result.measure).to eq("urgent")

        # user makes second choice
        @comparison = Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t1.id, measure: "urgent")

        result = Comparison.next_pending_comparison

        expect(result).to_not eq(nil)
        expect(result.task_left_id).to eq(@t2.id)
        expect(result.task_right_id).to eq(@t3.id)
        expect(result.measure).to eq("urgent")

        # user makes third choice
        @comparison = Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t2.id, measure: "urgent")

        result = Comparison.next_pending_comparison

        expect(result).to eq(nil)
      end
    end
  end

  context '.generate_comparisons' do
    context 'given there are no tasks' do
      it 'returns an empty list' do
        result = Comparison.generate_comparisons
        expect(result.size).to be(0)
      end
    end

    context 'given there is one task' do
      before :each do
        @a = Task.create(description: "A")
      end
      it 'returns an empty list' do
        result = Comparison.generate_comparisons
        expect(result.size).to be(0)
      end
    end

    context 'given there are two tasks' do
      before :each do
        @a = Task.create(description: "A")
        @b = Task.create(description: "B")
      end

      it 'generates one comparison' do
        result = Comparison.generate_comparisons

        expect(result.size).to be(2)
      end
      it 'is two comparisons of A and b' do
        result = Comparison.generate_comparisons

        expect(result[0].task_left_id).to be(@a.id)
        expect(result[0].task_right_id).to be(@b.id)
        expect(result[0].measure).to eq("important")

        expect(result[1].task_left_id).to be(@a.id)
        expect(result[1].task_right_id).to be(@b.id)
        expect(result[1].measure).to eq("urgent")
      end
    end

    context 'given there are three tasks' do
      before :each do
        @a = Task.create(description: "A")
        @b = Task.create(description: "B")
        @c = Task.create(description: "C")
      end

      it 'generates 6 comparisons' do
        result = Comparison.generate_comparisons

        expect(result.size).to be(6)
      end

      it 'is comparison of A - B, A - C and B - C for importance and urgency' do
        result = Comparison.generate_comparisons

        expect(result[0].task_left_id).to eq(@a.id)
        expect(result[0].task_right_id).to eq(@b.id)
        expect(result[0].measure).to eq("important")

        expect(result[1].task_left_id).to eq(@a.id)
        expect(result[1].task_right_id).to eq(@c.id)
        expect(result[1].measure).to eq("important")

        expect(result[2].task_left_id).to eq(@b.id)
        expect(result[2].task_right_id).to eq(@c.id)
        expect(result[2].measure).to eq("important")

        expect(result[3].task_left_id).to eq(@a.id)
        expect(result[3].task_right_id).to eq(@b.id)
        expect(result[3].measure).to eq("urgent")

        expect(result[4].task_left_id).to eq(@a.id)
        expect(result[4].task_right_id).to eq(@c.id)
        expect(result[4].measure).to eq("urgent")

        expect(result[5].task_left_id).to eq(@b.id)
        expect(result[5].task_right_id).to eq(@c.id)
        expect(result[5].measure).to eq("urgent")
      end
    end
  end
end
