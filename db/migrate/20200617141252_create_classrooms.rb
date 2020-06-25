class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.references :address, foreign_key: true, null: true

      t.timestamps
    end
  end
end
