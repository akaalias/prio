class ComparisonsController < ApplicationController
  def new
    @remaining_comparisons = Combinator.possible_combinations - Comparison.count
    @comparison = Comparison.next_pending_comparison
    @task_left = Task.find(@comparison.task_left_id)
    @task_right = Task.find(@comparison.task_right_id)
  end

  def create
    @comparison = Comparison.new(comparison_params)

    @comparison.save

    if Comparison.count == Combinator.possible_combinations
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
