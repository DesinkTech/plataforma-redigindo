class AddLabelToCorrectionComments < ActiveRecord::Migration[6.0]
  def change
    add_column :correction_comments, :label_id, :string, null: false
    add_column :correction_comments, :label_coords, :string, null: false
  end
end
