class Airport < ApplicationRecord
  validates_presence_of :name, :iata_code, :latitude, :longitude
end
