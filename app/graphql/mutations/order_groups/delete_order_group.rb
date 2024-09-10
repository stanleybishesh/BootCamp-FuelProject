class Mutations::OrderGroups::DeleteOrderGroup < Mutations::BaseMutation
  argument :order_group_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        order_group = OrderGroup.find(order_group_id)
        if order_group.destroy
          {
            message: "Order Group deleted successfully",
            errors: []
          }
        else
          {
            message: "Order Group failed to delete",
            errors: [ order_group.errors.full_messages ]
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
