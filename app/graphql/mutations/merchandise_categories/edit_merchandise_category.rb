class Mutations::MerchandiseCategories::EditMerchandiseCategory < Mutations::BaseMutation
  argument :merchandise_category_id, ID, required: true
  argument :name, String, required: true
  argument :description, String, required: false

  field :merchandise_category, Types::MerchandiseCategories::MerchandiseCategoryType
  field :message, String

  def resolve(merchandise_category_id:, name:, description:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        merchandise_category = MerchandiseCategory.find(merchandise_category_id)
        if merchandise_category.update(name: name, description: description)
          {
            merchandise_category: merchandise_category,
            message: "Merchandise Category successfully updated"
          }
        else
          {
            merchandise_category: [],
            message: "Failed to edit merchandise category"
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "Merchandise not found"
    end
  end
end
