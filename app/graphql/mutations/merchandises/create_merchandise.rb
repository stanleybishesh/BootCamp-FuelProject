module Mutations
  module Merchandises
    class CreateMerchandise < BaseMutation
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: false
      field :errors, [ String ], null: false
      field :message, String, null: true

      def resolve(merchandise_info:)
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            merchandise = Merchandise.new(merchandise_info.to_h)
            if merchandise.save
              {
                merchandise: merchandise,
                errors: [],
                message: "Merchandise created successfully"
              }
            else
              {
                merchandise: nil,
                errors: merchandise.errors.full_messages,
                message: "Unable to create #{merchandise_info.name}"
              }
            end
          end
        end
      end
    end
  end
end
