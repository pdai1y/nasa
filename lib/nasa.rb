# frozen_string_literal: true

require 'dotenv/load'
require 'rest-client'
require 'sqlite3'

require 'nasa/version'
require 'nasa/configuration'
require 'nasa/api/rest'
require 'nasa/api/responses'
require 'nasa/api/services/neo_ws'

# Main entry to the gem
module NASA
  extend NASA::Configuration
end
