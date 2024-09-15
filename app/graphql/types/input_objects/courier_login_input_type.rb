module Types
  module InputObjects
    class CourierLoginInputType < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
