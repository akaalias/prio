class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @sorted_tasks = []
    @highest_rank = 0

    if Comparison.count > 0
      for t in @tasks
        rank = Comparison.where(['choice_id = ?', t.id]).count
        t.rank = rank

        if rank > @highest_rank
          @highest_rank = rank
        end
      end
      @sorted_tasks = @tasks.sort_by(&:rank).reverse
    else
      @sorted_tasks = @tasks
    end
  end

  def create
    Task.delete_all
    Comparison.delete_all
    if(params[:tasks].include?("\r"))
      descriptions = params[:tasks].split("\r\n")
    else
      descriptions = params[:tasks].split('\n')
    end

    for d in descriptions
      Task.create(description: d)
    end

    redirect_to '/comparisons/new'
  end
end
