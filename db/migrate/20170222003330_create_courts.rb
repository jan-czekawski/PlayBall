class CreateCourts < ActiveRecord::Migration[5.0]
  def change
    create_table :courts do |t|
      t.string :name
      t.string :picture
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
