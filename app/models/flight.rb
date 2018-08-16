class Flight < ApplicationRecord
  has_many :flight_fares, -> { order(created_at: :desc)}
  validates :arrival_station, :departure_station, :date, presence: true

  scope :watching, ->{ where(stop_watching: false) }

  def departure_airport
    Airport.find_by(iata_code: departure_station)
  end

  def arrival_airport
    Airport.find_by(iata_code: arrival_station)
  end
end
