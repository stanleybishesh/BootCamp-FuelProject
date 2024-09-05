# frozen_string_literal: true

module Types
  module Merchandises
    class MerchandiseType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :status, String
      field :category, Integer
      field :description, String
      field :price, Float
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :tenant_id, Integer
    end
  end
end
