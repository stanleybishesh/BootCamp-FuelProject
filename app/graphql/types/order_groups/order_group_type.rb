# frozen_string_literal: true

module Types
  module OrderGroups
    class OrderGroupType < Types::BaseObject
      field :id, ID, null: false
      field :tenant_id, Integer
      field :client_id, Integer
      field :venue_id, Integer
      field :start_on, GraphQL::Types::ISO8601Date, null: true
      field :completed_on, GraphQL::Types::ISO8601DateTime, null: true
      field :status, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :delivery_order, Types::DeliveryOrders::DeliveryOrderType, null: false
      field :client, Types::Clients::ClientType, null: false
      field :venue, Venues::VenueType
    end
  end
end
