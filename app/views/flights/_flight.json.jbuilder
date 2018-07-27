json.extract! flight, :id, :departure_station, :arrival_station, :date, :passenger_count, :wizz_discount_club, :created_at, :updated_at
json.url flight_url(flight, format: :json)
