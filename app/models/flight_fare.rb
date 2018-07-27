class FlightFare < ApplicationRecord
  belongs_to :flight
  validates :price, presence: true
end
