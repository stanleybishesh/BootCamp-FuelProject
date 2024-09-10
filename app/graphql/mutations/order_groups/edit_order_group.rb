class Mutations::OrderGroups::EditOrderGroup < Mutations::BaseMutation
  argument :order_group_id, ID, required: true
  argument :order_group_info, Types::InputObjects::OrderGroupInputType, required: true

  field :order_group, Types::OrderGroups::OrderGroupType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_id:, order_group_info:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        order_group = OrderGroup.find(order_group_id)
        if order_group.update(order_group_info.to_h)
          {
            order_group: order_group,
            message: "Order Group updated successfully",
            errors: []
          }
        else
          {
            order_group: nil,
            message: "Order Group failed to edit",
            errors: [ order_group.errors.full_messages ]
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
