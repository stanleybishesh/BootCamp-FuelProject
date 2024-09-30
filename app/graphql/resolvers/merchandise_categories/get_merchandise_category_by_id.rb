class Resolvers::MerchandiseCategories::GetMerchandiseCategoryById < Resolvers::BaseResolver
  argument :merchandise_category_id, ID, required: true
  type Types::MerchandiseCategories::MerchandiseCategoryType, null: true

  def resolve(merchandise_category_id:)
    begin
      if current_user
        merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(merchandise_category_id: merchandise_category_id).execute_get_merchandise_category_by_id
        if merchandise_category_service.success?
          merchandise_category_service.merchandise_category
        else
          raise GraphQL::ExecutionError, merchandise_category_service.errors
        end
      else
        raise GraphQL::UnauthorizedError, "User not logged in"
      end
    rescue GraphQL::UnauthorizedError => err
      raise err
    rescue GraphQL::ExecutionError => err
      raise err
    rescue StandardError => err
      raise GraphQL::ExecutionError, "An unexpected error occurred: #{err.message}"
    end
  end
end
