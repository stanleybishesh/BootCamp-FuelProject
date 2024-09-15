class Types::InputObjects::LineItemInputType < Types::BaseInputObject
  argument :merchandise_category_id, ID, required: true
  argument :merchandise_id, ID, required: true
  argument :quantity, Integer, required: true
  argument :price, Float, required: false
  argument :unit, String, required: true
end
