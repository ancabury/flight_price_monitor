require 'net/http'

module Flights
  class SearchFlightFareJob
    def initialize(flight)
      @flight = flight

      setup_request
    end

    def perform
      response = @http.request(@request)
      response_body = JSON.parse(response.body).with_indifferent_access
      SaveFlightFareJob.new(flight, response_body).perform
    rescue JSON::ParserError
      Rails.logger.error "Error parsing response body #{response.body}"
    end

    private

    attr_accessor :flight

    def setup_request
      uri = URI.parse('https://be.wizzair.com/8.2.0/Api/search/search')
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @request = Net::HTTP::Post.new(uri.request_uri)
      @request.add_field('Content-Type', 'application/json')
      @request.body = request_body
    end

    def request_body
      {
        isFlightChange: false,
        isSeniorOrStudent: false,
        flightList:
          [
            {
              departureStation: flight.departure_station,
              arrivalStation: flight.arrival_station,
              departureDate: flight.date.to_date
            }
          ],
        adultCount: flight.passenger_count,
        childCount: 0,
        infantCount: 0,
        wdc: flight.wizz_discount_club
      }.to_json
    end
  end
end
