class AddStopWatchingToFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :stop_watching, :boolean, default: false
  end
end
