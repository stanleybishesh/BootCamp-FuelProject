class Resolvers::MerchandiseCategories::GetAllMerchandiseCategories < Resolvers::BaseResolver
  type [ Types::MerchandiseCategories::MerchandiseCategoryType ], null: true

  def resolve
    begin
      if current_user
        merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new.execute_get_all_merchandise_categories
        if merchandise_category_service.success?
          merchandise_category_service.merchandise_categories
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
