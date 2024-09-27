class Resolvers::DeliveryOrders::GetAllDeliveryOrders < Resolvers::BaseResolver
  type [ Types::OrderGroups::OrderGroupType ], null: true

  def resolve
    begin
      if current_user
        order_group_service = ::OrderGroups::OrderGroupService.new.execute_get_all_delivery_orders
        if order_group_service.success?
          order_group_service.delivery_orders
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
