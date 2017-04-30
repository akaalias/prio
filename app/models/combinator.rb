class Combinator
  def self.generate_comparisons

    tasks = Task.all
    if tasks.count < 2
      return []
    else
      return [Comparison.new(task_left_id: tasks.first.id, task_right_id: tasks.second.id)]
    end
  end
end
