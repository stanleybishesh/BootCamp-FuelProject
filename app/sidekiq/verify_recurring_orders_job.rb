class VerifyRecurringOrdersJob
  include Sidekiq::Job

  def perform
    OrderGroup.where("recurring IS NOT NULL").find_each do |order_group|
      frequency = order_group.recurring["frequency"]
      start_date = Date.parse(order_group.recurring["start_date"])
      end_date = Date.parse(order_group.recurring["end_date"])

      check_and_create_missing_orders(order_group, frequency, start_date, end_date)
    end
  end

  private

  def check_and_create_missing_orders(order_group, frequency, start_date, end_date)
    current_date = start_date
    created_orders = []

    while current_date <= end_date
      unless order_group_for_date_exists?(order_group, current_date)
        new_order_group = order_group.dup
        new_order_group.created_at = current_date
        new_order_group.updated_at = current_date
        new_order_group.save!
        created_orders << new_order_group
      end

      current_date = get_next_date(current_date, frequency)
    end

    puts "Created #{created_orders.size} missing order groups"
  end

  def order_group_for_date_exists?(order_group, date)
    OrderGroup.exists?(customer_id: order_group.customer_id, branch_id: order_group.branch_id, created_at: date.beginning_of_day..date.end_of_day)
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
