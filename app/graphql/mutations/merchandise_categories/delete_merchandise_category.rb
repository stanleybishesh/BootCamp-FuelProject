class Mutations::MerchandiseCategories::DeleteMerchandiseCategory < Mutations::BaseMutation
  argument :merchandise_category_id, ID, required: true

  field :message, String

  def resolve(merchandise_category_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        merchandise_category = MerchandiseCategory.find(merchandise_category_id)
        if merchandise_category.destroy
          {
            message: "Merchandise Category successfully deleted"
          }
        else
          {
            message: "Failed to delete merchandise category"
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "Merchandise not found"
    end
  end
end
