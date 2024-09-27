class Resolvers::OrderGroups::GetChildrenRecurringOrders < Resolvers::BaseResolver
  type [ Types::OrderGroups::OrderGroupType ], null: true

  argument :main_recurring_order_id, ID, required: true

  def resolve(main_recurring_order_id:)
    begin
      if current_user
        order_group_service = ::OrderGroups::OrderGroupService.new(main_recurring_order_id: main_recurring_order_id).execute_get_children_recurring_orders
        if order_group_service.success?
          order_group_service.recurring_orders
        else
          raise GraphQL::ExecutionError, order_group_service.errors
        end
      else
        raise GraphQL::UnauthorizedError, "User not logged in"
      end
    rescue GraphQL::UnauthorizedError => err
      raise err
    rescue GraphQL::ExecutionError => err
      raise err
    rescue StandardError => err
      raise GraphQL::ExecutionError, "An unexpected error occurred: #{err.message}"
    end
  end
end
