module Mutations
  module Users
    class Login < BaseMutation
      argument :login_data, Types::InputObjects::UserLoginInputType, required: true

      field :token, String, null: false
      field :user, Types::Users::UserType, null: true

      def resolve(login_data:)
        user = User.find_by(email: login_data.email)

        if user&.valid_password?(login_data.password)
          jti = SecureRandom.uuid
          token = ::JWT.encode({ user_id: user.id, jti: jti, exp: 1.hour.from_now.to_i }, "secret", "HS256")

          # Optionally, store the JTI in the database or a cache with an expiration time
          user.update(jti: jti)

          { token: token, user: user }
        else
          raise GraphQL::ExecutionError, "Invalid email or password"
        end
      end
    end
  end
end
