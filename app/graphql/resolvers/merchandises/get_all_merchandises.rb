module Resolvers
  module Merchandises
    class GetAllMerchandises < BaseResolver
      type [ Types::Merchandises::MerchandiseType ], null: false

      def resolve
        merchandise_service = ::Merchandises::MerchandiseService.new(current_user: current_user).execute_get_all_merchandises

        if merchandise_service.success?
          merchandise_service.merchandises
        else
          raise GraphQL::ExecutionError, merchandise_service.errors
        end
      end
    end
  end
end
