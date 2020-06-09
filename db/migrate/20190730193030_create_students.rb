class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :registration_number
      t.integer :submissions, default: 0, null: false
      t.integer :reviewed_submissions, default: 0, null: false
      t.integer :credits, default: 3, null: false
      t.references :category, foreign_key: { on_delete: :cascade }, null: false
      t.references :school, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    
    add_index :students, :registration_number, unique: true
  end
end
