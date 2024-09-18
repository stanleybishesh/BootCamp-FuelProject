module Mutations
  module Couriers
    class CourierSignin < BaseMutation
      argument :login_data, Types::InputObjects::CourierLoginInputType, required: true

      field :token, String, null: false
      field :courier, Types::Couriers::CourierType, null: true
      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve(login_data:)
        begin
          courier_service = ::Couriers::CourierService.new(login_data.to_h).execute_courier_login
          if courier_service.success?
            {
              token: courier_service.token,
              courier: courier_service.courier,
              message: "Courier signed in successfully",
              errors: []
            }
          else
            {
              token: nil,
              courier: nil,
              message: "Courier login failed",
              errors: [ courier_service.errors ]
            }
          end
        rescue GraphQL::ExecutionError => err
          {
            token: nil,
            courier: nil,
            message: "Courier login failed",
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
