class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :continent
      t.string :country
      t.string :city
      t.string :iata_code

      t.timestamps
    end
  end
end
