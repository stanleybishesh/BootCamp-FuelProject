module Mutations
  module Merchandises
    class CreateMerchandise < BaseMutation
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: false
      field :errors, [ String ], null: false

      def resolve(merchandise_info:)
        # merchandise_attr = merchandise_info.to_h
        tenant = Tenant.find_by(id: merchandise_info.tenant_id)
        raise GraphQL::ExecutionError, "Tenant does not exist !" if tenant.nil?

        # formatted_price = merchandise_info[:price].to_i
        merchandise = tenant.merchandises.new(merchandise_info.to_h)

        if merchandise.save
          {
            merchandise: merchandise,
            errors: []
          }
        else
          {
            merchandise: nil,
            errors: merchandise.errors.full_messages
          }
        end
      end
    end
  end
end
