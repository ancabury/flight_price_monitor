class CreateFlightFares < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_fares do |t|
      t.integer :flight_id
      t.float :price
      t.string :currency
      t.integer :available_count

      t.timestamps
    end
  end
end
