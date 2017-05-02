class ComparisonsController < ApplicationController
  def new
    @remaining_comparisons = Combinator.possible_combinations - Comparison.count
    @comparison = Comparison.next_pending_comparison
    @task_left = Task.find(@comparison.task_left_id)
    @task_right = Task.find(@comparison.task_right_id)
    @current_progress = ((Comparison.count.to_f / Combinator.possible_combinations.to_f) * 100.0)
  end

  def create
    @comparison = Comparison.new(comparison_params)
    @comparison.save

    if Comparison.count == Combinator.possible_combinations
      redirect_to '/tasks'
    else
      redirect_to '/comparisons/new'
    end
  end

  def reprioritize
    Comparison.delete_all
    redirect_to '/comparisons/new'
  end

  private
  def comparison_params
    params.require(:comparison).permit(:choice_id, :task_left_id, :task_right_id)
  end
end
