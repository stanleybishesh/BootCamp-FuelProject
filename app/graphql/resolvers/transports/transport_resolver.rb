module Resolvers
  module Transports
    class TransportResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      def resolve
        Transport.all
      end
    end
  end
end
