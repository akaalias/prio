class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @sorted_tasks = []

    if Comparison.count > 0
      for t in @tasks
        t.rank = Comparison.where(['choice_id = ?', t.id]).count
      end
      @sorted_tasks = @tasks.sort_by(&:rank).reverse
    else
      @sorted_tasks = @tasks
    end
  end
end
