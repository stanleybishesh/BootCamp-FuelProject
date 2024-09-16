module Resolvers
  module Merchandises
    class GetAllMerchandises < BaseResolver
      type [ Types::Merchandises::MerchandiseType ], null: false

      def resolve
        service = ::Merchandises::MerchandiseService.new(current_user: current_user).execute_get_all_merchandises

        if service.success?
          service.merchandises
        else
          raise GraphQL::ExecutionError, service.errors
        end
      end
    end
  end
end
