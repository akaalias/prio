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
end
