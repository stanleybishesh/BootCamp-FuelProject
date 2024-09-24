class Resolvers::DeliveryOrders::GetAllDeliveryOrders < Resolvers::BaseResolver
  type [ Types::OrderGroups::OrderGroupType ], null: false

  def resolve
    begin
      order_group_service = ::OrderGroups::OrderGroupService.new(current_user: current_user).execute_get_all_delivery_orders
      if order_group_service.success?
        order_group_service.delivery_orders
      else
        raise GraphQL::ExecutionError, order_group_service.errors
      end
    rescue GraphQL::ExecutionError => err
      raise GraphQL::ExecutionError, err.message
    end
  end
end
