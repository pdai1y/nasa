# frozen_string_literal: true

module NASA
  module Response
    # Base Response
    class BaseResponse
      # @!attribute [r] code
      #   @return [Integer] HTTP Status code
      # @!attribute [r] headers
      #   @return [Hash] Parsed HTTP Headers
      # @!attribute [r] body
      #   @return [Hash] HTTP Body JSON
      # @!attribute [r] message
      #   @return [String] Error message, if any
      # @!attribute [r] raw_response
      #   @return [RestClient::Response] Unparsed response
      # @!attribute [r] remaining_requests
      #   @return [Integer] Remaining hourly
      #     requests available
      attr_reader :code, :headers, :body, :message, :raw_response, :remaining_requests

      def initialize(response)
        @raw_response = response
        parse_response(response)
      end

      # JSON {#body} key lookup shorthand
      # @param [String] key
      # @return [String] key value.
      def [](key)
        @body[key]
      end

      # @param [RestClient::Response]
      # @return nothing, used by #super in decendants
      def parse_response(response)
        raise NotImplementedError
      end
    end

    # Handles and parses non error responses from the API
    class RestResponse < BaseResponse
      def initialize(response)
        super(response)
      end

      # Parses response from successful API calls
      #
      # @param [RestClient::Response] response
      def parse_response(response)
        @code = response.code
        begin
          @body = JSON.parse(response.body, symbolize_names: true)
        rescue JSON::ParserError
          @body = {}
        end
        @headers = response.headers
        @remaining_requests = @headers[:'X-RateLimit-Remaining']
      end
    end

    # Handles and parses error responses from the API
    class ExceptionResponse < BaseResponse
      def initialize(response)
        super(response)
      end

      # Parses response from failed API calls
      #
      # @param [RestClient::ExceptionWithResponse] response
      # @return [Hash] Parsed JSON body from response
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
end
