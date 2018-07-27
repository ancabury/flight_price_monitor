class CheckPrices
  def perform
    Flight.find_each do |f|
      p "Search flight fares for: #{f.departure_station} -> #{f.arrival_station}"
      Flights::SearchFlightFareJob.new(f).perform
    end
  end
end
