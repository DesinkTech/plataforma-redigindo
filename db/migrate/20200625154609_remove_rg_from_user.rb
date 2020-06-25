class RemoveRgFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :rg, :string
  end
end
