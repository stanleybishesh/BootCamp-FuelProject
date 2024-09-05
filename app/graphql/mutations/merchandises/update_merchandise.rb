module Mutations
  module Merchandises
    class UpdateMerchandise < BaseMutation
      argument :merchandise_info, Types::InputObjects::MakeMerchandiseInputType, required: true
      argument :id, ID, required: true

      field :merchandise, Types::Merchandises::MerchandiseType, null: false
      field :errors, [ String ], null: false

      def resolve(id:, merchandise_info:)
        merchandise_attr = merchandise_info.to_h
        tenant = Tenant.find_by(id: merchandise_info.tenant_id)
        raise GraphQL::ExecutionError, "Tenant does not exist !" if tenant.nil?

        merchandise = tenant.merchandises.new(merchandise_attr)

        if merchandise.update!(merchandise_attr)
          {
            merchandise: merchandise,
            errors: []
          }
        else
          {
            merchandise: nil,
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
