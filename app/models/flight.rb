class Flight < ApplicationRecord
  has_many :flight_fares, -> { order(created_at: :desc)}
  validates :arrival_station, :departure_station, :date, presence: true
end
