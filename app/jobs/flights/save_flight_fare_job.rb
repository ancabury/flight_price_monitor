module Flights
  class SaveFlightFareJob
    def initialize(flight, attributes)
      @flight = flight
      @attributes = attributes
    end

    def perform
      FlightFare.create permitted_attributes
    end

    private

    def permitted_attributes
      {
        flight_id: @flight.id,
        price: basic_flight_details[:basePrice][:amount],
        currency: basic_flight_details[:basePrice][:currencyCode],
        available_count: basic_flight_details[:availableCount]
      }
    end

    def basic_flight_details
      @details ||= @attributes[:outboundFlights].first[:fares].select { |fare|
        fare[:bundle] == 'BASIC' && fare[:wdc] == @flight.wizz_discount_club }.first
    end
  end
end
