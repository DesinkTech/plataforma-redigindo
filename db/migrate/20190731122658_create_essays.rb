class CreateEssays < ActiveRecord::Migration[5.2]
  def change
    create_table :essays do |t|
      t.string :hash_id, null: false, default: ""
      t.date :submission_date, null: false
      t.boolean :active, default: true
      t.references :student, foreign_key: true, null: false
      t.references :theme, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end

    add_index :essays, :hash_id, unique: true
  end
end
