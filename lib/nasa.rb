# frozen_string_literal: true

require 'dotenv/load'
require 'rest-client'
require 'mongoid'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.push_dir("#{__dir__}/nasa/utils")
loader.push_dir("#{__dir__}/nasa/api")
loader.push_dir("#{__dir__}/nasa/models")
loader.logger = method(:puts)
loader.setup
loader.eager_load

# Main entry to the gem
module NASA
  extend Configuration

  # Setup MongoDB
  current_env = ENV['MONGOID_ENV']&.to_sym || :development

  Mongoid.load!("#{Dir.pwd}/mongoid.yml", current_env)

  Mongoid::QueryCache.enabled = true
end
