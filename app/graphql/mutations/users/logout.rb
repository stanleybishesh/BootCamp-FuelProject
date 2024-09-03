module Mutations
  module Users
    class Logout < BaseMutation
      field :success, Boolean, null: true
      field :message, String, null: true

      def resolve
        user = current_user
        if user
          new_jti = SecureRandom.uuid
          user.update(jti: new_jti) # Invalidate the JTI
          { success: true, message: "Logged Out Successfully !" }
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
