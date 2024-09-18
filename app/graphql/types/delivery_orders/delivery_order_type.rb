# frozen_string_literal: true

module Types
  module DeliveryOrders
    class DeliveryOrderType < Types::BaseObject
      field :id, ID, null: false
      field :order_group_id, Integer
      field :source, String
      field :vehicle_type, String
      field :transport_id, ID, null: false
      field :courier_id, ID, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :line_items, [ Types::LineItems::LineItemType ], null: false
      field :transport, Transports::TransportType, null: false
      field :courier, Couriers::CourierType, null: false
    end
  end
end
