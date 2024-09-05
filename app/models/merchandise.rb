class Merchandise < ApplicationRecord
  belongs_to :tenant
  has_many :line_items

    enum status: { active: "active", inactive: "inactive", pending: "pending" }
end
