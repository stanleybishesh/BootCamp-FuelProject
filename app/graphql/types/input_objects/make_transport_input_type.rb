module Types
  module InputObjects
    class MakeTransportInputType < BaseInputObject
      argument :name, String, required: true
      argument :status, String, required: true
      # argument :type, String, required: true
      argument :category, String, required: true
      argument :tenant_id, ID, required: true
    end
  end
end
