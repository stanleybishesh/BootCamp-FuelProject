class OrderGroup < ApplicationRecord
  after_initialize :set_default_start_on, :set_default_status, if: :new_record?

  validates :recurring, presence: true, if: :recurring_order?

  enum status: {
    pending: "pending",
    processing: "processing",
    delivered: "delivered",
    cancelled: "cancelled"
  }

  has_one :delivery_order, dependent: :destroy
  belongs_to :client
  belongs_to :venue
  accepts_nested_attributes_for :delivery_order
  # belongs_to :tenant

  acts_as_tenant(:tenant)

  def recurring_order?
    recurring.present?
  end

  private

  def set_default_start_on
    self.start_on ||= Date.today
  end

  def set_default_status
    self.status ||= "pending"
  end
end
