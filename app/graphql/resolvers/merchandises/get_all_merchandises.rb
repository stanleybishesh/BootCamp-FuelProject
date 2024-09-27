module Resolvers
  module Merchandises
    class GetAllMerchandises < BaseResolver
      type [ Types::Merchandises::MerchandiseType ], null: true

      def resolve
        if current_user
          merchandise_service = ::Merchandises::MerchandiseService.new.execute_get_all_merchandises
          if merchandise_service.success?
            merchandise_service.merchandises
          else
            raise GraphQL::ExecutionError, merchandise_service.errors
          end
        else
          raise GraphQL::UnauthorizedError, "User not logged in"
        end
      end
    end
  end
end
