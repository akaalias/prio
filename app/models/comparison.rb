class Comparison < ApplicationRecord
  def choice
    Task.find(self.choice_id)
  end

  def loser
    if(self.choice_id == self.task_left_id)
      Task.find(self.task_right_id)
    else
      Task.find(self.task_left_id)
    end
  end

  def self.next_pending_comparison

    return nil if Task.all.count == 0

    possible_comparisons = Combinator.generate_comparisons

    return possible_comparisons[Comparison.all.count]
  end
end
