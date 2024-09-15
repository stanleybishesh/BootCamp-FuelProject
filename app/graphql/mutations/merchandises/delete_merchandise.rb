module Mutations
  module Merchandises
    class DeleteMerchandise < BaseMutation
      argument :merchandise_id, ID, required: true

      field :message, String, null: true

      def resolve(merchandise_id:)
        user = current_user
        ActsAsTenant.with_tenant(user.tenant) do
          merchandise = Merchandise.find(merchandise_id)
          if merchandise.destroy
            {
              message: "Merchandise Deleted"
            }
          else
            {
              message: "Failed to delete Merchandise"
            }
          end
        end
      end
    end
  end
end
