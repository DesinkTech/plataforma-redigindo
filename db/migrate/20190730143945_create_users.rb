class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_digest , null: false
      t.boolean :active, default: true, null: false
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :cpf, null: false, limit: 11
      t.string :rg, null: false, limit: 9
      t.string :remember_digest
      t.string :verification_digest
      t.boolean :verified, default: false
      t.datetime :verified_at
      t.string :reset_digest
      t.datetime :reset_at
      t.references :role, foreign_key: true, default: 3, null: false
      t.references :address, foreign_key: true, null: false

      t.timestamps
    end

    add_index :users, [:email, :username, :cpf], unique: true
  end
end
