module Types
  module InputObjects
    class UserLoginInputType < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
