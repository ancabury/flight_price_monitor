namespace :compute_mean_price do
  desc 'Compute the mean price of a flight for legacy entries. Should be run once.'
  task :legacy => :environment do
    Flight.find_each do |flight|
      results = flight.flight_fares.group_by { |f| f.created_at.beginning_of_day }

      results.values.map do |day_prices|
        average_price = day_prices.inject(0) { |sum, el| sum + el.price }.to_f / day_prices.size
        flight_fare = day_prices.first
        new_avg_fare = FlightFare.new(
          {
            flight_id: flight.id,
            price: average_price,
            currency: flight_fare.currency,
            available_count: flight_fare.available_count,
            created_at: flight_fare.created_at
          }
        )
        day_prices.map(&:destroy)

        new_avg_fare.save!
      end
    end
  end

  desc 'Compute the mean price of a flight per day'
  task :daily => :environment do
    Flight.find_each do |flight|
      results = flight.flight_fares.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

      average_price = results.inject(0) { |sum, el| sum + el.price }.to_f / results.size
      flight_fare = results.first
      new_avg_fare = FlightFare.new(
        {
          flight_id: flight.id,
          price: average_price,
          currency: flight_fare.currency,
          available_count: flight_fare.available_count,
          created_at: flight_fare.created_at
        }
      )
      results.map(&:destroy)

      new_avg_fare.save!
    end
  end
end
