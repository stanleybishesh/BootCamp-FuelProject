class Mutations::MerchandiseCategories::CreateMerchandiseCategory < Mutations::BaseMutation
  argument :name, String, required: true
  argument :description, String, required: false

  field :merchandise_category, Types::MerchandiseCategories::MerchandiseCategoryType
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(name:, description:)
    begin
      merchandise_category_service = ::MerchandiseCategories::MerchandiseCategoryService.new(name: name, description: description, current_user: current_user).execute_create_merchandise_category
      if merchandise_category_service.success?
        {
          merchandise_category: merchandise_category_service.merchandise_category,
          message: "Merchandise category created successfully",
          errors: []
        }
      else
        {
          merchandise_category: nil,
          message: "Merchandise category failed to create",
          errors: [ merchandise_category_service.errors ]
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        merchandise_category: nil,
        messages: "Merchandise category failed to create",
        errors: [ err.message ]
      }
    end
  end
end
