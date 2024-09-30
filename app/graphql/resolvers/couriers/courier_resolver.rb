module Resolvers
  module Couriers
    class CourierResolver < BaseResolver
      type [ Types::Couriers::CourierType ], null: true

      def resolve
        if current_user
          Courier.all
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
