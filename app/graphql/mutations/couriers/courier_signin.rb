module Mutations
  module Couriers
    class CourierSignin < BaseMutation
      argument :login_data, Types::InputObjects::CourierLoginInputType, required: true

      field :token, String, null: false
      field :courier, Types::Couriers::CourierType, null: true
      field :message, String, null: true

      def resolve(login_data:)
        courier = Courier.find_by(email: login_data.email)
        if courier
          ActsAsTenant.with_tenant(courier.tenant) do
            if courier&.valid_password?(login_data.password)
              jti = SecureRandom.uuid
              token = ::JWT.encode({ courier_id: courier.id, jti: jti, exp: 1.day.from_now.to_i, type: "courier" }, "secret", "HS256")

              courier.update(jti: jti)
              { token: token, courier: courier, message: "You Logged In Successfully" }
            else
              raise GraphQL::ExecutionError, "Invalid email or password"
            end
          end
        else
          raise GraphQL::ExecutionError, "Courier not registered"
        end
      end
    end
  end
end
