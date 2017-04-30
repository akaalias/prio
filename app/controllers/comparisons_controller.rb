class ComparisonsController < ApplicationController
  def new
    @remaining_comparisons = Task.count - Comparison.count

    if Comparison.count == 0
      @task_left = Task.first()
      @task_right = Task.second()
    elsif Comparison.count == 1
      @task_left = Task.first()
      @task_right = Task.third()
    else
      @task_left = Task.second()
      @task_right = Task.third()
    end

    @comparison = Comparison.new()
  end

  def create
    @comparison = Comparison.new(comparison_params)

    @comparison.save

    if Comparison.count == 3
      flash[:notice] = "You compared all Tasks"
      redirect_to '/tasks'
    else
      flash[:notice] = "You chose #{@comparison.choice.description} over #{@comparison.loser.description}"
      redirect_to '/comparisons/new'
    end

  end

  private
  def comparison_params
    params.require(:comparison).permit(:choice_id, :task_left_id, :task_right_id)
  end
end
