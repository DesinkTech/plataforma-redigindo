class AddTextCutToCorrectionComments < ActiveRecord::Migration[6.0]
  def change
    add_column :correction_comments, :text_cut, :string, null: false, default: ""
  end
end
