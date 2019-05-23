# frozen_string_literal: true

# Base model object
class MongoObject
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
end
