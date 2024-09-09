module Resolvers
  module Couriers
    class CourierResolver < BaseResolver
      type [ Types::Couriers::CourierType ], null: false

      def resolve
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            Courier.all
          end
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
