desc 'Check prices for all flights registered in the DB'
task :check_prices => :environment do
  Flight.watching.find_each do |f|
    p "Search flight fares for: #{f.departure_station} -> #{f.arrival_station}"
    Flights::SearchFlightFareJob.new(f).perform
  end
end
