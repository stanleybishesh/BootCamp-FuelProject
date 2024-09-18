# frozen_string_literal: true

module Types
  module Transports
    class TransportType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :vehicle_type, String
      field :tenant_id, Integer
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :status, String
    end
  end
end
