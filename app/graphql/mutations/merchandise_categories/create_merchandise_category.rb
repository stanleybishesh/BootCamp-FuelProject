class Mutations::MerchandiseCategories::CreateMerchandiseCategory < Mutations::BaseMutation
  argument :name, String, required: true
  argument :description, String, required: false

  field :merchandise_category, Types::MerchandiseCategories::MerchandiseCategoryType
  field :message, String

  def resolve(name:, description:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        merchandise_category = MerchandiseCategory.new(name: name, description: description)
        if merchandise_category.save
          {
            merchandise_category: merchandise_category,
            message: "Merchandise Category successfully created"
          }
        else
          {
            merchandise_category: [],
            message: "Failed to create merchandise category"
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "Merchandiese cannot be created"
    end
  end
end
