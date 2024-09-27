class Mutations::OrderGroups::CreateOrderGroup < Mutations::BaseMutation
  argument :order_group_info, Types::InputObjects::OrderGroupInputType, required: true

  field :order_group, Types::OrderGroups::OrderGroupType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(order_group_info:)
    begin
      if current_user
        order_group_service = ::OrderGroups::OrderGroupService.new(order_group_info.to_h).execute_create_order_group
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
      else
        {
          order_group: nil,
          message: "You are not authorized to perform this action.",
          errors: [ "User not logged in" ]
        }
      end
    rescue StandardError => err
      {
        order_group: nil,
        message: "Order Group failed to create",
        errors: [ err.message ]
      }
    end
  end
end
