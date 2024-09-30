class Mutations::MerchandiseCategories::DeleteMerchandiseCategory < Mutations::BaseMutation
  argument :merchandise_category_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(merchandise_category_id:)
    begin
      if current_user
        merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(
          merchandise_category_id: merchandise_category_id,
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
      else
        {
          message: "You are not authorized to perform this action.",
          errors: [ "User not logged in" ]
        }
      end
    rescue StandardError => err
      {
        message: "Failed to delete merchandise category",
        errors: [ err.message ]
      }
    end
  end
end
