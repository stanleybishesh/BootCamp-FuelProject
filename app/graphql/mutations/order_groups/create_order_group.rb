class Mutations::OrderGroups::CreateOrderGroup < Mutations::BaseMutation
  argument :order_group_info, Types::InputObjects::OrderGroupInputType, required: true

  field :order_group, Types::OrderGroups::OrderGroupType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_info:)
    begin
      order_group_service = ::OrderGroups::OrderGroupService.new(order_group_info.to_h.merge(current_user: current_user)).execute_create_order_group
      if order_group_service.success?
        {
          order_group: order_group_service.order_group,
          message: "Order Group created successfully",
          errors: []
        }
      else
        {
          order_group: nil,
          message: "Order Group failed to create",
          errors: [ order_group_service.errors ]
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        order_group: nil,
        message: "Order Group failed to create",
        errors: [ err.message ]
      }
    end
  end
end
