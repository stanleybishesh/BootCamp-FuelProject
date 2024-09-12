class Merchandise < ApplicationRecord
  # belongs_to :tenant
  enum status: { available: "available", out_of_stock: "out_of_stock" }

  belongs_to :merchandise_category
  has_many :line_items
end
