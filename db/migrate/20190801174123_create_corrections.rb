class CreateCorrections < ActiveRecord::Migration[5.2]
  def change
    create_table :corrections do |t|
      t.string :hash_id, null: false, default: ""
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.integer :final_score, default: 0, null: false
      t.text :final_comment
      t.boolean :valid_essay, default: true, null: false
      t.references :student, foreign_key: true, null: false
      t.references :essay, foreign_key: true, null: false
      t.references :reviewer, foreign_key: true, null: true
      t.references :admin, foreign_key: true, null: true

      t.timestamps
    end

    add_index :corrections, :hash_id, unique: true
  end
end
