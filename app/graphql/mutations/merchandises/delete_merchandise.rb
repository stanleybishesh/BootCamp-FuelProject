module Mutations
  module Merchandises
    class DeleteMerchandise < BaseMutation
      argument :merchandise_id, ID, required: true

      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve(merchandise_id:)
        if current_user
          merchandise_service = ::Merchandises::MerchandiseService.new(merchandise_id: merchandise_id).execute_delete_merchandise
          if merchandise_service.success?
            {
              message: "Merchandise Deleted",
              errors: []
            }
          else
            {
              message: "Failed to delete Merchandise",
              errors: [ merchandise_service.errors ]
            }
          end
        else
          {
            message: "You are not authorized to perform this action.",
            errors: [ "User not logged in" ]
          }
        end
      end
    end
  end
end
