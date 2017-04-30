class AddChoiceId < ActiveRecord::Migration[5.1]
  def change
    add_column :comparisons, :choice_id, :integer
  end
end
