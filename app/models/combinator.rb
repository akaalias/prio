class Combinator
  def self.generate_comparisons

    tasks = Task.all

    if tasks.count < 2
      return []
    else
      # generate all possibilities
      all_combinations = []

      for task_left in tasks
        for task_right in tasks
          unless task_left.id == task_right.id
            c = Comparison.new(task_left_id: task_left.id, task_right_id: task_right.id)
            all_combinations << c
          end
        end
      end
      return all_combinations[0...((all_combinations.size / 2))]
    end
  end
end
