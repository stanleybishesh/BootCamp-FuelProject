class Mutations::OrderGroups::ChangeStatusToDelivered < Mutations::BaseMutation
  argument :order_group_id, ID, required: true

  field :order_group, Types::OrderGroups::OrderGroupType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_id:)
    begin
      order_group_service = ::OrderGroups::OrderGroupService.new(current_user: current_user, order_group_id: order_group_id).execute_change_status_to_delivered
      if order_group_service.success?
        {
          order_group: order_group_service.order_group,
          message: "Order Group status changed to 'delivered' successfully",
          errors: []
        }
      else
        {
          order_group: nil,
          message: "Order Group status failed to change",
          errors: [ order_group_service.errors ]
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        order_group: nil,
        message: "Order Group status failed to change",
        errors: [ err.message ]
      }
    end
  end
end
