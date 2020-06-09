class CreateReviewers < ActiveRecord::Migration[5.2]
  def change
    create_table :reviewers do |t|
      t.integer :reviewed, default: 0, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
