class Resolvers::MerchandiseCategories::GetMerchandiseCategoryById < Resolvers::BaseResolver
  argument :merchandise_category_id, ID, required: true
  type Types::MerchandiseCategories::MerchandiseCategoryType, null: false

  def resolve(merchandise_category_id:)
    merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(
      merchandise_category_id: merchandise_category_id, current_user: current_user
    ).execute_get_merchandise_category_by_id

    if merchandise_category_service.success?
      merchandise_category_service.merchandise_category
    else
      raise GraphQL::ExecutionError, merchandise_category_service.errors
    end
  end
end
