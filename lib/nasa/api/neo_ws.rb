# frozen_string_literal: true

# NeoWs (Near Earth Object Web Service)
# With NeoWs a user can: search for Asteroids based on their closest approach date to Earth,
# lookup a specific Asteroid with its NASA JPL small body id,
# as well as browse the overall data-set.
class NeoWs
  # Base API Endpoint for this service
  ENDPOINT = 'https://api.nasa.gov/neo/rest/v1/'

  extend Rest

  # Retrieve a list of Asteroids based on their closest approach date to Earth.
  # @param [String] start_date formatted as YYYY-MM-DD
  #   defaults to today
  # @param [String] end_date formatted as YYYY-MM-DD
  #   defaults to 7 days after start_date (serverside)
  # @raise [ArgumentError] if incorrect date format provided
  # @return [NASA::RestResponse]
  def self.feed(start_date, end_date = nil)
    start_date ||= Time.new.strftime('%F')
    date_check = ->(date) { date.match(/\d{4}-\d{2}-\d{2}/) }

    raise ArgumentError, 'Incorrect date format' unless date_check.call(start_date)

    raise ArgumentError, 'Incorrect date format' unless end_date && date_check.call(end_date)

    params = { start_date: start_date, end_date: end_date }

    get("#{ENDPOINT}/feed", params: params)
  end

  # Lookup a specific Asteroid based on its NASA JPL small body (SPK-ID) ID
  #
  # @param [Integer] asteroid_id Asteroid SPK-ID
  # @return [NASA::RestResponse]
  def self.lookup(asteroid_id)
    get("#{ENDPOINT}/neo/#{asteroid_id}")
  end

  # Browse the overall Asteroid data-set
  # @param [Integer] page which page to request
  # @param [Integer] size amount of objects per page,
  #   the api defaults to 20
  # @return [NASA::RestResponse]
  def self.browse(page: nil, size: nil)
    get("#{ENDPOINT}/neo/browse", params: { page: page, size: size })
  end
end
