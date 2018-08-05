require 'csv'

namespace :airports do

  desc 'Update the list of airports that have scheduled flights. Source file was downloaded from: http://ourairports.com'
  task :import, [:file_path] => [:environment] do |_, args|
    CSV.foreach(args[:file_path], headers: true) do |row|
      next unless has_scheduled_flights?(row)
      next unless is_of_type_medium_or_large?(row)

      airport = Airport.find_or_initialize_by(latitude: row['latitude_deg'], longitude: row['longitude_deg'])
      airport.update_attributes(
        name: row['name'],
        continent: row['continent'],
        country: row['iso_country'],
        city: row['municipality'],
        iata_code: row['iata_code']
      )
    rescue ActiveRecord::RecordInvalid => e
      p "Error: #{e}"
    end
  end

  def has_scheduled_flights?(row)
    row['scheduled_service'] == 'yes'
  end

  def is_of_type_medium_or_large?(row)
    %w(medium_airport large_airport).include? row['type']
  end
end
