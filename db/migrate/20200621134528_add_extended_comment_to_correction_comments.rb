class AddExtendedCommentToCorrectionComments < ActiveRecord::Migration[6.0]
  def change
    add_column :correction_comments, :extended_comment, :string
  end
end
