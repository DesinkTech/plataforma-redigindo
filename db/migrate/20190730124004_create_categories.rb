class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :description
      t.integer :max_score, null: false

      t.timestamps
    end
  end
end
