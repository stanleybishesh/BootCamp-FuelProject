module Types
  module InputObjects
    class MakeMerchandiseInputType < BaseInputObject
      argument :name, String, required: true
      argument :status, Types::Merchandises::MerchandiseStatusType, required: true
      argument :description, String, required: false
      argument :price, Float, required: true
      argument :unit, String, required: true
    end
  end
end
