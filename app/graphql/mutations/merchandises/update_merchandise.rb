module Mutations
  module Merchandises
    class UpdateMerchandise < BaseMutation
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true
      argument :id, ID, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: true

      def resolve(id:, merchandise_info:)
        merchandise_attr = merchandise_info.to_h
        merchandise = Merchandise.find(id)

        if merchandise.update(merchandise_attr)
          {
            merchandise: merchandise,
            errors: [],
            message: "Merchandise updated successfully"
          }
        else
          {
            merchandise: nil,
            errors: [ err.message ],
            message: "Unable to edit merchandise"
          }
        end
      end
    end
  end
end
