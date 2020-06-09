class CreateCorrectionComments < ActiveRecord::Migration[5.2]
  def change
    create_table :correction_comments do |t|
      t.references :correction, foreign_key: true, null: false
      t.references :comment, foreign_key: true, null: false
      t.string :essay_line, null: false
      t.integer :penalty, null: false, default: 0 
      

      t.timestamps
    end
  end
end
