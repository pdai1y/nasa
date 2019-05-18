# frozen_string_literal: true

module NASA
  # Base configuration for the gem
  module Configuration
    # @return [String]
    attr_reader :api_key
    # @return [Boolean]
    #  Can be set from {NASA} namespace
    attr_accessor :debug

    # Configures the gem
    #
    # @yield [config]
    # @yieldparam api_key [String] Sets the NASA API Key
    #   Can be pulled from ENV `nasa_api_key` or set in
    #   the configure block
    # @see https://api.nasa.gov/index.html#apply-for-an-api-key
    # @yieldparam debug [Boolean] Enable/Disable Rest logging
    def configure
      yield self
    end

    def api_key
      @api_key ||= ENV['nasa_api_key'] || nil
    end

    def debug
      @debug ||= nil
    end
  end
end
