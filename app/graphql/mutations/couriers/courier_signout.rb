module Mutations
  module Couriers
    class CourierSignout < BaseMutation
      field :success, Boolean, null: true
      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve
        begin
          if current_courier
            courier_service = ::Couriers::CourierService.new(current_courier: current_courier).execute_courier_logout
            if courier_service.success?
              {
                success: true,
                message: "Logged out successfully",
                errors: []
              }
            else
              {
                success: false,
                message: "Logout failed",
                errors: [ courier_service.errors ]
              }
            end
          else
            {
              success: false,
              message: "Logout failed",
              errors: [ "Courier not logged in" ]
            }
          end
        rescue StandardError => err
          {
            success: false,
            message: "Logout failed",
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
