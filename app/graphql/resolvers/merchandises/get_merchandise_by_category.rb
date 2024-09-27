module Resolvers
  module Merchandises
    class GetMerchandiseByCategory < BaseResolver
      argument :merchandise_category_id, ID, required: true
      type [ Types::Merchandises::MerchandiseType ], null: true

      def resolve(merchandise_category_id:)
        if current_user
          merchandise_service = ::Merchandises::MerchandiseService.new(merchandise_category_id: merchandise_category_id).execute_get_merchandises_by_category
          if merchandise_service.success?
            merchandise_service.merchandises
          else
            raise GraphQL::ExecutionError, service.errors
          end
        else
          raise GraphQL::UnauthorizedError, "User not logged in"
        end
      end
    end
  end
end
