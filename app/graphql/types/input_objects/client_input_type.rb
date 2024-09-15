module Types
  module InputObjects
    class ClientInputType < BaseInputObject
      argument :name, String, required: true
      argument :email, String, required: true
      argument :address, String, required: false
      argument :phone, String, required: false
    end
  end
end
