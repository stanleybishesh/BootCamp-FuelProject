class Types::InputObjects::DeliveryOrderInputType < Types::BaseInputObject
  argument :source, String, required: false
  argument :vehicle_type, Types::Transports::VehicleType, required: true
  argument :transport_id, ID, required: true
  argument :courier_id, ID, required: true
  argument :line_items_attributes, [ Types::InputObjects::LineItemInputType ], required: true
end
