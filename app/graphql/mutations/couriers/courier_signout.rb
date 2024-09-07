module Mutations
  module Couriers
    class CourierSignout < BaseMutation
      include TokenHelper

      field :success, Boolean, null: true
      field :message, String, null: true

      def resolve
        token = context[:headers]["Authorization"].to_s.split(" ").last
        return { success: false, message: "Courier not logged in" } unless token

        decoded_token = JWT.decode(token, "secret", true, algorithm: "HS256")[0]
        return { success: false, message: "Courier not logged in" } unless decoded_token["type"] == "courier" && decoded_token["courier_id"]

        courier = Courier.find_by(id: decoded_token["courier_id"])

        if courier && courier.jti == decoded_token["jti"]
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
