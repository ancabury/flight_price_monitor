class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :departure_station
      t.string :arrival_station
      t.integer :passenger_count, default: 1
      t.boolean :wizz_discount_club, default: true
      t.datetime :date

      t.timestamps
    end
  end
end
