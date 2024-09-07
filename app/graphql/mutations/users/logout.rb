module Mutations
  module Users
    class Logout < BaseMutation
      include TokenHelper

      field :success, Boolean, null: true
      field :message, String, null: true

      def resolve
        token = context[:headers]["Authorization"].to_s.split(" ").last
        return { success: false, message: "User not logged in" } unless token

        decoded_token = JWT.decode(token, "secret", true, algorithm: "HS256")[0]
        return { success: false, message: "User not logged in" } unless decoded_token["type"] == "user" && decoded_token["user_id"]

        user = User.find_by(id: decoded_token["user_id"])

        if user && user.jti == decoded_token["jti"]
          ActsAsTenant.with_tenant(user.tenant) do
            new_jti = SecureRandom.uuid
            user.update(jti: new_jti) # Invalidate the JTI
            { success: true, message: "Logged Out Successfully!" }
          end
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
