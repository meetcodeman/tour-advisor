class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips, id: :uuid do |t|
      t.jsonb :destination_details
      t.string :name, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.string :status, null: false, default: 'PLANNED'
      t.uuid :user_id

      t.timestamps
    end

    add_foreign_key :trips, :users, column: :user_id, type: :uuid
  end
end
