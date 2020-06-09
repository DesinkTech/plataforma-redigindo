class CreateCompetences < ActiveRecord::Migration[5.2]
  def change
    create_table :competences do |t|
      t.string :description
      t.integer :max_penalty, null: false
      t.integer :penalty_division, null: false, default: 0
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
