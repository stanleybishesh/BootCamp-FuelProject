class Resolvers::MerchandiseCategories::GetAllMerchandiseCategories < Resolvers::BaseResolver
  type [Types::MerchandiseCategories::MerchandiseCategoryType], null: false

  def resolve
    merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(current_user: current_user).execute_get_all_merchandise_categories

    if merchandise_category_service.success?
      merchandise_category_service.merchandise_categories
    else
      raise GraphQL::ExecutionError, merchandise_category_service.errors
    end
  end
end
