class Resolvers::OrderGroups::GetNonRecurringOrders < Resolvers::BaseResolver
  type [ Types::OrderGroups::OrderGroupType ], null: false

  def resolve
    begin
      order_group_service = ::OrderGroups::OrderGroupService.new(current_user: current_user).execute_get_non_recurring_orders
      if order_group_service.success?
        order_group_service.non_recurring_orders
      else
        raise GraphQL::ExecutionError, order_group_service.errors
      end
    rescue GraphQL::ExecutionError => err
      raise GraphQL::ExecutionError, err.message
    end
  end
end
