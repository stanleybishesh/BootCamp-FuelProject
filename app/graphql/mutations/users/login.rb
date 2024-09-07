module Mutations
  module Users
    class Login < BaseMutation
      argument :login_data, Types::InputObjects::UserLoginInputType, required: true

      field :token, String, null: false
      field :user, Types::Users::UserType, null: true
      field :message, String, null: true

      def resolve(login_data:)
        user = User.find_by(email: login_data.email)
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            if user&.valid_password?(login_data.password)
              jti = SecureRandom.uuid
              token = ::JWT.encode({ user_id: user.id, jti: jti, exp: 1.day.from_now.to_i }, "secret", "HS256")

              # Optionally, store the JTI in the database or a cache with an expiration time
              user.update(jti: jti)
              { token: token, user: user, message: "Logged In Successfully" }
            else
              raise GraphQL::ExecutionError, "Invalid email or password"
            end
          end
        else
          raise GraphQL::ExecutionError, "User not registered"
        end
      end
    end
  end
end
