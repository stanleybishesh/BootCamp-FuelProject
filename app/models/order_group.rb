class OrderGroup < ApplicationRecord
  acts_as_tenant(:tenant)

  after_initialize :set_default_start_on, if: :new_record?
  before_save :set_default_status, :set_default_completed_on

  validates :recurring, presence: true, if: :recurring_order?

  enum status: {
    pending: "pending",
    processing: "processing",
    delivered: "delivered",
    cancelled: "cancelled"
  }

  has_one :delivery_order, dependent: :destroy
  has_many :children_order_groups, class_name: "OrderGroup", foreign_key: "main_order_group_id", dependent: :nullify
  belongs_to :main_order_group, class_name: "OrderGroup", optional: true
  belongs_to :client, -> { with_deleted }
  belongs_to :venue, -> { with_deleted }
  accepts_nested_attributes_for :delivery_order
  # belongs_to :tenant

  def recurring_order?
    recurring.present?
  end

  def main_order_group?
    main_order_group_id.nil?
  end

  def child_order_group?
    main_order_group_id.present?
  end

  def child_order_updated?(child_order)
    child_order.manual_update
  end

  def mark_child_order_as_updated(child_order)
    child_order.update(manual_update: true)
  end

  private

  def set_default_start_on
    self.start_on ||= DateTime.current
  end

  def set_default_status
    return if delivered? || cancelled?
    self.status = delivery_order&.courier_id.nil? ? "pending" : "processing"
  end

  def set_default_completed_on
    self.completed_on = DateTime.current if status_changed? && delivered?
  end
end
