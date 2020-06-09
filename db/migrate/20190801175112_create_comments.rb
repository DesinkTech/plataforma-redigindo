class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :description, null: false
      t.references :competence, foreign_key: true, null: false

      t.timestamps
    end
  end
end
