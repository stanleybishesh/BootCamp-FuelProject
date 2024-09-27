module Mutations
  module Merchandises
    class CreateMerchandise < BaseMutation
      argument :merchandise_category_id, ID, required: true
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: true
      field :errors, [ String ], null: true
      field :message, String, null: true

      def resolve(merchandise_category_id:, merchandise_info:)
        if current_user
          merchandise_service = ::Merchandises::MerchandiseService.new(merchandise_info.to_h.merge(merchandise_category_id: merchandise_category_id)).execute_create_merchandise
          if merchandise_service.success?
            {
              merchandise: merchandise_service.merchandise,
              errors: [],
              message: "Merchandise created successfully"
            }

          else
            {
              merchandise: nil,
              errors: [ merchandise_service.errors ],
              message: "Merchandise creation failed"
            }
          end
        else
          {
            merchandise: nil,
            errors: [ "User not logged in" ],
            message: "You are unauthorized to perform this action."
          }
        end
      end
    end
  end
end
