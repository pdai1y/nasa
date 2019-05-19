# frozen_string_literal: true

require 'dotenv/load'
require 'json'
require 'rest-client'

require 'nasa/version'
require 'nasa/configuration'
require 'nasa/api/rest'
require 'nasa/api/services/neo_ws'

# Main entry to the gem
module NASA
  extend NASA::Configuration
end
