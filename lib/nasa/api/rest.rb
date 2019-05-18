# frozen_string_literal: true

module NASA
  # CRUD Rest actions to be plug and play into all API Services
  module Rest
    def get(url, payload: nil, params: nil)
      request(:get, url, payload: payload, params: params)
    end

    def post(url, payload: nil, params: nil)
      request(:post, url, payload: payload, params: params)
    end

    def put(url, payload: nil, params: nil)
      request(:put, url, payload: payload, params: params)
    end

    def delete(url, payload: nil, params: nil)
      request(:delete, url, payload: payload, params: params)
    end

    def request(action, url, payload: nil, params: nil)
      options = rest_options(action, url, payload: payload, params: params)
      response = RestClient::Request.execute(options)

      NASA::RestResponse.new(response)
    rescue RestClient::ExceptionWithResponse => ex
      NASA::ExceptionResponse.new(ex)
    end

    private

    def headers(params)
      { params: params }.merge!(api_key: NASA.api_key)
    end

    def rest_options(action, url, payload: nil, params: nil)
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
