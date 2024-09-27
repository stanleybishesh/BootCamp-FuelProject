module Mutations
  module Users
    class Logout < BaseMutation
      field :success, Boolean, null: true
      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve
        begin
          user_service = ::Users::UserService.new(current_user: current_user).execute_user_logout
          if user_service.success?
            {
              success: user_service.success,
              message: "Logged out successfully",
              errors: []
            }
          else
            {
              success: user_service.success,
              message: "Log out failed",
              errors: [ user_service.errors ]
            }
          end
        rescue StandardError => err
          {
            success: false,
            message: "Log out failed",
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
