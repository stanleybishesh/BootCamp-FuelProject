class Types::InputObjects::OrderGroupInputType < Types::BaseInputObject
  # argument :start_on, GraphQL::Types::ISO8601Date, required: true
  # argument :completed_on, GraphQL::Types::ISO8601DateTime, required: true
  # argument :status, String, required: true, default_value: "pending"
  argument :client_id, ID, required: true
  argument :venue_id, ID, required: true
  argument :delivery_order_attributes, Types::InputObjects::DeliveryOrderInputType, required: true
  argument :recurring, Types::InputObjects::RecurringInputType, required: false
end
