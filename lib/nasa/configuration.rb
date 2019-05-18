# frozen_string_literal: true

module NASA
  # Base configuration for the gem
  module Configuration
    attr_writer :api_key, :debug

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
