# frozen_string_literal: true

module Types
  module Transports
    class TransportType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :status, Integer
      field :type, String
      field :category, String
      field :tenant_id, Integer
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
