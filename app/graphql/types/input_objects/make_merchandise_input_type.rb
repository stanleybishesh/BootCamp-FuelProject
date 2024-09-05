module Types
  module InputObjects
    class MakeMerchandiseInputType < BaseInputObject
      argument :name, String, required: true
      argument :status, Types::Merchandises::StatusType, required: true
      # argument :type, String, required: true
      # argument :category, Merchandises::CategoryType, required: true
      argument :price, Float, required: true
      # argument :quantity, Integer, required: true
      argument :tenant_id, ID, required: true
    end
  end
end
