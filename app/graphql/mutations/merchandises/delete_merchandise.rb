module Mutations
  module Merchandises
    class DeleteMerchandise < BaseMutation
      argument :merchandise_id, ID, required: true

      field :message, String, null: true
      field :errors, [ String ], null: false

      def resolve(merchandise_id:)
        service = ::Merchandises::MerchandiseService.new({ merchandise_id: merchandise_id }.merge(current_user: current_user)).execute_delete_merchandise

        if service.success?
          {
            message: "Merchandise Deleted",
            errors: []
          }
        else
          {
            message: "Failed to delete Merchandise",
            errors: service.errors
          }
        end
      end
    end
  end
end
