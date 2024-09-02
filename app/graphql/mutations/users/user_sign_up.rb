module Mutations
  module Users
    class UserSignUp < BaseMutation
      argument :user_data, Types::InputObjects::UserSignupInputType, required: true

      field :user, Types::Users::UserType, null: true
      field :errors, [ String ], null: false

      def resolve (user_data:)
        tenant = Tenant.find_by(id: user_data.tenant_id)
        raise GraphQL::ExecutionError, "Tenant does not exist !" if tenant.nil?

        user = tenant.users.new(user_data.to_h)


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
