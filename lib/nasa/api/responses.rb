# frozen_string_literal: true

module NASA
  # Base response class
  class Response
    attr_accessor :code, :headers, :body, :message, :raw_response

    def initialize(response)
      @raw_response = response
      parse_response(response)
    end
  end

  # Handles and parses non error responses from the API
  class RestResponse < Response
    def initialize(response)
      super(response)
      parse_response(response)
    end

    def parse_response(response)
      @code = response.code
      begin
        @body = JSON.parse(response.body, symbolize_names: true)
      rescue JSON::ParserError
        @body = {}
      end
      @headers = response.headers
    end

    def [](key)
      @body[key]
    end
  end

  # Handles and parses error responses from the API
  class ExceptionResponse < Response
    def initialize(response)
      super(response)
      parse_response(response)
    end

    def parse_response(response)
      @code = response.http_code
      begin
        @body = JSON.parse(response.http_body, symbolize_names: true)
      rescue JSON::ParserError
        @body = {}
      end
      @message = @body[:message]
      @headers = response.http_headers
    end
  end
end
