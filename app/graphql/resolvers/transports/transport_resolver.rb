module Resolvers
  module Transports
    class TransportResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      def resolve
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            Transport.all
          end
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
