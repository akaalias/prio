class AddTaskColums < ActiveRecord::Migration[5.1]
  def change
    add_column :comparisons, :task_left_id, :integer
    add_column :comparisons, :task_right_id, :integer
  end
end
