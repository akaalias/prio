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

    possible_comparisons = self.generate_comparisons

    return possible_comparisons[Comparison.all.count]
  end

  def self.generate_comparisons
    result = []

    # create the important comparisons
    for combo in Combinator.unique_combinations(Task.all.map(&:id))
      result << Comparison.new(task_left_id: combo[0], task_right_id: combo[1], measure: 'important')
    end

    # create the urgent comparisons
    for combo in Combinator.unique_combinations(Task.all.map(&:id))
      result << Comparison.new(task_left_id: combo[0], task_right_id: combo[1], measure: 'urgent')
    end

    return result
  end
end
