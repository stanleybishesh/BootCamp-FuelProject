module Types
  module InputObjects
    class UserLoginInputType < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
      # argument :tenant_id, ID, required: true
    end
  end
end