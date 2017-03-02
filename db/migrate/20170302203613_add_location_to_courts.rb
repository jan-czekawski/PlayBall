class AddLocationToCourts < ActiveRecord::Migration[5.0]
  def change
    add_column :courts, :longitude, :decimal
    add_column :courts, :latitude, :decimal
  end
end
