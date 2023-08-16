class AddCityNameToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :city_name, :string, null: false
  end
end
