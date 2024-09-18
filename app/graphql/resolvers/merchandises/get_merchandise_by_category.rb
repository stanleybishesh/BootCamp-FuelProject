module Resolvers
  module Merchandises
    class GetMerchandiseByCategory < BaseResolver
      argument :merchandise_category_id, ID, required: true
      type [ Types::Merchandises::MerchandiseType ], null: false

      def resolve(merchandise_category_id:)
        merchandise_service = ::Merchandises::MerchandiseService.new({ merchandise_category_id: merchandise_category_id }.merge(current_user: current_user)).execute_get_merchandises_by_category

        if merchandise_service.success?
          merchandise_service.merchandises
        else
          raise GraphQL::ExecutionError, service.errors
        end
      end
    end
  end
end
