module Mutations
  module Merchandises
    class DeleteMerchandise < BaseMutation
      argument :id, ID, required: true

      field :message, String, null: true
      field :errors, [ String ], null: false

      def resolve(id:)
        merchandise = Merchandise.find_by(id: id)

        if merchandise.nil?
          {
            message: "Failed to delete Merchandise",
            errors: "Merchandise not found!"

          }
        end

        if merchandise.destroy
          {
            message: "Merchandise Deleted",
            errors: []
          }
        else
          {
            message: "Failed to delete Transport",
            errors: [ "Transport Couldnot be deleted" ]
          }
        end
      end
    end
  end
end
