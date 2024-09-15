module Mutations
  module Couriers
    class CourierSignout < BaseMutation
      field :success, Boolean, null: true
      field :message, String, null: true

      def resolve
        courier = current_courier
        if courier
          ActsAsTenant.with_tenant(courier.tenant) do
            new_jti = SecureRandom.uuid
            courier.update(jti: new_jti)
            { success: true, message: "Logged Out Successfully!" }
          end
        else
          raise GraphQL::ExecutionError, "Courier not logged in"
        end
      end
    end
  end
end
