module Mutations
  module Users
    class Logout < BaseMutation
      field :success, Boolean, null: true
      field :message, String, null: true

      def resolve
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            new_jti = SecureRandom.uuid
            user.update(jti: new_jti)
            { success: true, message: "Logged Out Successfully!" }
          end
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
