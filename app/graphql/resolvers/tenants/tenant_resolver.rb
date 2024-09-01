module Resolvers
  module Tenants
    class TenantResolver < BaseResolver
      type Types::Tenants::TenantType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        ::Tenant.find(id)
      end
    end
  end
end
