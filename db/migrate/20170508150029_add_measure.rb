class AddMeasure < ActiveRecord::Migration[5.1]
  def change
    add_column :comparisons, :measure, :string
  end
end
