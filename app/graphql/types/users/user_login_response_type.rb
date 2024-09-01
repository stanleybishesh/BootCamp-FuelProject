module Types
  module Users
    class UserLoginResponseType < Types::BaseObject
      field :user, Types::Users::UserType, null: true
      field :errors, [String], null: false
    end
  end
end
