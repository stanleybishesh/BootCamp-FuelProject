class Mutations::MerchandiseCategories::EditMerchandiseCategory < Mutations::BaseMutation
  argument :merchandise_category_id, ID, required: true
  argument :name, String, required: true
  argument :description, String, required: false

  field :merchandise_category, Types::MerchandiseCategories::MerchandiseCategoryType
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(merchandise_category_id:, name:, description:)
    begin
      merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(
        name: name,
        description: description,
        merchandise_category_id: merchandise_category_id,
        current_user: current_user
      ).execute_update_merchandise_category

      if merchandise_category_service.success?
        {
          merchandise_category: merchandise_category_service.merchandise_category,
          message: "Merchandise category updated successfully",
          errors: []
        }
      else
        {
          merchandise_category: nil,
          message: "Merchandise category failed to update",
          errors: merchandise_category_service.errors.split(". ")
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        merchandise_category: nil,
        message: "Merchandise category failed to update",
        errors: [ err.message ]
      }
    end
  end
end
