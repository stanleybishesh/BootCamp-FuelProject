class RecurringOrderJob
  include Sidekiq::Job

  def perform(order_group_id)
    begin
      order_group = OrderGroup.find(order_group_id)

      if order_group.recurring.present?
        frequency = order_group.recurring["frequency"]
        start_date = Date.parse(order_group.recurring["start_date"])
        end_date = Date.parse(order_group.recurring["end_date"])

        create_future_order_groups(order_group, frequency, start_date, end_date)
      end
    rescue StandardError => e
      Rails.logger.error "RecurringOrderJob failed: #{e.message}"
    end
  end

  private

  def create_future_order_groups(order_group, frequency, start_date, end_date)
    current_date = start_date
    created_orders = []

    while current_date <= end_date
      new_order_group = order_group.dup
      new_order_group.start_on = current_date
      new_order_group.completed_on = nil

      if order_group.delivery_order.present?
        new_delivery_order = order_group.delivery_order.dup
        new_order_group.delivery_order = new_delivery_order

        order_group.delivery_order.line_items.each do |line_item|
          new_line_item = line_item.dup
          new_delivery_order.line_items << new_line_item
        end
        new_delivery_order.save!
      end
      new_order_group.delivery_order = new_delivery_order if new_delivery_order.present?

      if new_order_group.save
        created_orders << new_order_group
      else
        Rails.logger.error "Failed to save OrderGroup: #{new_order_group.errors.full_messages.join(', ')}"
      end

      current_date = get_next_date(current_date, frequency)
    end

    puts "Created #{created_orders.size} future order groups"
  end

  def get_next_date(current_date, frequency)
    case frequency
    when "daily"
      current_date + 1.day
    when "weekly"
      current_date + 1.week
    when "monthly"
      current_date + 1.month
    else
      raise "Unsupported frequency: #{frequency}"
    end
  end
end
