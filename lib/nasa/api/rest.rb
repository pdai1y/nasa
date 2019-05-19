# frozen_string_literal: true
require 'nasa/api/responses'

module NASA
  # CRUD Rest actions to be plug and play into all API Services
  module Rest
    extend NASA::Responses

    # @!macro crud
    #   @param [String] url the url to send a request to
    #   @param [Hash] payload the JSON payload to send
    #   @param [Hash] params the URL params to send
    #   @return [NASA::RestResponse] if the API call was sucessful
    #   @return [NASA::ExceptionResponse] if the API call failed

    # @!method get(url, payload: {}, params: {})
    #   @!macro crud
    # @!method post(url, payload: {}, params: {})
    #   @!macro crud
    # @!method put(url, payload: {}, params: {})
    #   @!macro crud
    # @!method delete(url, payload: {}, params: {})
    #   @!macro crud
    %w[get post put delete].each do |action|
      define_method(:"#{action}") do |url, payload: {}, params: {}|
        request(:"#{action}", url, payload, params)
      end
    end

    # Performs a CRUD action to the requested URL
    # @!macro crud
    def request(action, url, payload, params)
      options = rest_options(action, url, payload, params)
      response = RestClient::Request.execute(options)

      Responses::RestResponse.new(response)
    rescue RestClient::ExceptionWithResponse => ex
      Responses::ExceptionResponse.new(ex)
    end

    private

    def headers(params = {})
      {
        params: {
          api_key: NASA.api_key
        }
      }.merge!(params)
    end

    def rest_options(action, url, payload, params)
      logger = Logger.new(STDERR) if NASA.debug
      rest_options = {
        method: action,
        url: url,
        accept: :json,
        payload: payload,
        headers: headers(params),
        log: logger
      }
      rest_options
    end
  end
end
