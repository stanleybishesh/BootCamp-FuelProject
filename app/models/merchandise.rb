class Merchandise < ApplicationRecord
  # belongs_to :tenant
  has_many :line_items

  enum status: { available: "available", out_of_stock: "out_of_stock" }

  belongs_to :merchandise_category
  acts_as_tenant(:tenant)
end
