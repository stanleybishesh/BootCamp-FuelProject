module Types
  module InputObjects
    class UserSignupInputType < BaseInputObject
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      # argument :confirm_password, String, required: true
      argument :tenant_id, ID, required: true
    end
  end
end
