# frozen_string_literal: true
require 'nasa/api/rest'

module NASA
  # NeoWs (Near Earth Object Web Service)
  # With NeoWs a user can: search for Asteroids based on their closest approach date to Earth,
  # lookup a specific Asteroid with its NASA JPL small body id,
  # as well as browse the overall data-set.
  module NeoWs
    # Base API Endpoint for this service
    ENDPOINT = 'https://api.nasa.gov/neo/rest/v1/'

    module_function

    extend NASA::Rest

    # Retrieve a list of Asteroids based on their closest approach date to Earth.

    # @param [String] start_date formatted as YYYY-MM-DD
    # @param [String] end_date formatted as YYYY-MM-DD
    #   defaults to 7 days after start_date
    # @return [NASA::RestResponse]
    def feed(start_date, end_date)
      params = { start_date: start_date, end_date: end_date }

      get("#{ENDPOINT}/feed", params: params)
    end

    # Lookup a specific Asteroid based on its NASA JPL small body (SPK-ID) ID
    #
    # @param [Integer] asteroid_id Asteroid SPK-ID
    # @return [NASA::RestResponse]
    def lookup(asteroid_id)
      get("#{ENDPOINT}/neo/#{asteroid_id}")
    end

    # Browse the overall Asteroid data-set
    # @param [Integer] page which page to request
    # @param [Integer] size amount of objects per page,
    #   the api defaults to 20
    # @return [NASA::RestResponse]
    def browse(page: nil, size: nil)
      get("#{ENDPOINT}/neo/browse", params: { page: page, size: size })
    end
  end
end
