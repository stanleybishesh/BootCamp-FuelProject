module Mutations
  module Merchandises
    class UpdateMerchandise < BaseMutation
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true
      argument :merchandise_id, ID, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: true

      def resolve(merchandise_id:, merchandise_info:)
        user = current_user
        if user
          merchandise_attr = merchandise_info.to_h
          merchandise = Merchandise.find(merchandise_id)
          ActsAsTenant.with_tenant(user.tenant) do
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
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
