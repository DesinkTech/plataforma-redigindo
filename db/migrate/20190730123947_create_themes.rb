class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :hash_id, null: false, default: ""
      t.string :description
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end

    add_index :themes, :hash_id, unique: true
  end
end
