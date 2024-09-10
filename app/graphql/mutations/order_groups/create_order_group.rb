class Mutations::OrderGroups::CreateOrderGroup < Mutations::BaseMutation
  argument :order_group_info, Types::InputObjects::OrderGroupInputType, required: true

  field :order_group, Types::OrderGroups::OrderGroupType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_info:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        order_group = OrderGroup.new(order_group_info.to_h)
        if order_group.save
          {
            order_group: order_group,
            message: "Order Group created successfully",
            errors: []
          }
        else
          {
            order_group: nil,
            message: "Order Group failed to create",
            errors: [ order_group.errors.full_messages ]
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
