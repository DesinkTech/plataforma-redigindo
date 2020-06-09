class CreateCorrectionCompetences < ActiveRecord::Migration[5.2]
  def change
    create_table :correction_competences do |t|
      t.references :correction, foreign_key: true, null: false
      t.references :competence, foreign_key: true, null: false
      t.integer :penalty, null:false, default: 0

      t.timestamps
    end
  end
end
