require "jwt"

module Mutations
  module Users
    class Login < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :tenant_id, ID, required: true

      field :token, String, null: false

      def resolve(email:, password:, tenant_id:)
        tenant = Tenant.find(tenant_id)
        user = tenant.users.find_by(email: email)

        if user&.valid_password?(password)
          token = JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, "secret", "HS256")
          { token: token }
        else
          raise GraphQL::ExecutionError, "Invalid email or password"
        end
      end
    end
  end
end
