class Flight < ApplicationRecord
  has_many :flight_fares
  validates :arrival_station, :departure_station, :date, presence: true
end
