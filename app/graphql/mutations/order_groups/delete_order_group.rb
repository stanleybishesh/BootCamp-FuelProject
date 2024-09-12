class Mutations::OrderGroups::DeleteOrderGroup < Mutations::BaseMutation
  argument :order_group_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_id:)
    begin
      order_group_service = ::OrderGroups::OrderGroupService.new(current_user: current_user, order_group_id: order_group_id).execute_delete_order_group

      if order_group_service.success?
        {
          message: "Order Group deleted successfully",
          errors: []
        }
      else
        {
          message: "Order Group failed to delete",
          errors: [ order_group_service.errors ]
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        message: "Order Group failed to delete",
        errors: [ err.message ]
      }
    end
  end
end
