class Resolvers::OrderGroups::GetChildrenRecurringOrders < Resolvers::BaseResolver
  type [ Types::OrderGroups::OrderGroupType ], null: false

  argument :main_recurring_order_id, ID, required: true

  def resolve(main_recurring_order_id:)
    begin
      order_group_service = ::OrderGroups::OrderGroupService.new(main_recurring_order_id: main_recurring_order_id, current_user: current_user).execute_get_children_recurring_orders
      if order_group_service.success?
        order_group_service.recurring_orders
      else
        raise GraphQL::ExecutionError, order_group_service.errors
      end
    rescue GraphQL::ExecutionError => err
      raise GraphQL::ExecutionError, err.message
    end
  end
end
