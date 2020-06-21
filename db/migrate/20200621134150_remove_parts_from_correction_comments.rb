class RemovePartsFromCorrectionComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :correction_comments, :essay_line, :integer
    remove_column :correction_comments, :penalty, :integer
    remove_column :correction_comments, :text_cut, :string
  end
end
