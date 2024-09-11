module Mutations
  module Users
    class Login < BaseMutation
      argument :login_data, Types::InputObjects::UserLoginInputType, required: true

      field :token, String, null: false
      field :user, Types::Users::UserType, null: true
      field :errors, [ String ], null: true

      def resolve(login_data:)
        begin
          user_service = ::Users::UserService.new(login_data.to_h).execute_user_login
          if user_service.success?
            {
              token: user_service.token,
              user: user_service.user,
              errors: []
            }
          else
            {
              token: nil,
              user: nil,
              errors: [ user_service.errors ]
            }
          end
        rescue GraphQL::ExecutionError => err
          {
            token: nil,
            user: nil,
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
