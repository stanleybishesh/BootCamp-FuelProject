module Mutations
  module Merchandises
    class UpdateMerchandise < BaseMutation
      argument :merchandise_id, ID, required: true
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: true

      def resolve(merchandise_id:, merchandise_info:)
        merchandise_service = ::Merchandises::MerchandiseService.new(merchandise_info.to_h.merge(merchandise_id: merchandise_id, current_user: current_user)).execute_update_merchandise

        if merchandise_service.success?
          {
            merchandise: merchandise_service.merchandise,
            errors: [],
            message: "Merchandise updated successfully"
          }
        else
          {
            merchandise: nil,
            errors: merchandise_service.errors,
            message: "Merchandise update failed"
          }
        end
      end
    end
  end
end
