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

  def create
    if(params[:tasks].include?("\r"))
      descriptions = params[:tasks].split("\r\n")
    else
      descriptions = params[:tasks].split('\n')
    end

    for d in descriptions
      Task.create(description: d)
    end
    redirect_to '/tasks/'
  end
end
