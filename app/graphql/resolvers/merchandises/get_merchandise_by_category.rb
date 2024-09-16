module Resolvers
  module Merchandises
    class GetMerchandiseByCategory < BaseResolver
      argument :merchandise_category_id, ID, required: true
      type [ Types::Merchandises::MerchandiseType ], null: false

      def resolve(merchandise_category_id:)
        service = ::Merchandises::MerchandiseService.new({ merchandise_category_id: merchandise_category_id }.merge(current_user: current_user)).execute_get_merchandise_by_category

        if service.success?
          service.merchandises
        else
          raise GraphQL::ExecutionError, service.errors
        end
      end
    end
  end
end
