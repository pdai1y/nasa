# frozen_string_literal: true

# Base configuration for the gem
module Configuration
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

  # @return [String]
  def api_key
    @api_key ||= ENV['nasa_api_key'] || nil
  end

  # @return [Boolean]
  #  Can be set from {NASA} namespace
  def debug
    @debug ||= nil
  end
end
