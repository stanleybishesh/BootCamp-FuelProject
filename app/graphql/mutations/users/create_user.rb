module Mutations
  module Users
    class CreateUser < BaseMutation
      argument :user_data, Types::InputObjects::UserCreateInputType, required: true

      field :user, Types::Users::UserType, null: true
      field :errors, [ String ], null: false

      def resolve (user_data:)
        user = User.new(user_data.to_h)

        if user.save
          {
            user: user,
            errors: []
          }
        else
          {
            user: nil,
            errors: user.errors.full_messages
          }
        end
      end
    end
  end
end
