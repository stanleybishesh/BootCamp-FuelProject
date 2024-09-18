class Mutations::MerchandiseCategories::DeleteMerchandiseCategory < Mutations::BaseMutation
  argument :merchandise_category_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(merchandise_category_id:)
    begin
      merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(
        merchandise_category_id: merchandise_category_id,
        current_user: current_user
      ).execute_delete_merchandise_category

      if merchandise_category_service.success?
        {
          message: "Merchandise category deleted successfully",
          errors: []
        }
      else
        {
          message: "Failed to delete merchandise category",
          errors: [ merchandise_category_service.errors ]
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        message: "Failed to delete merchandise category",
        errors: [ err.message ]
      }
    end
  end
end
