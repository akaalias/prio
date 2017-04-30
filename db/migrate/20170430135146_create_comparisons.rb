class CreateComparisons < ActiveRecord::Migration[5.1]
  def change
    create_table :comparisons do |t|
      t.string :choice
      t.timestamps
    end
  end
end
