# frozen_string_literal: true

module Types
  module Clients
    class ClientType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :email, String
      field :address, String
      field :phone, String
    end
  end
end
