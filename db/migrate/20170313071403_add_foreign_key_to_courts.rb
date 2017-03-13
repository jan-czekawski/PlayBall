class AddForeignKeyToCourts < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :courts, :users
    add_index :courts, [:user_id, :created_at]
  end
end
