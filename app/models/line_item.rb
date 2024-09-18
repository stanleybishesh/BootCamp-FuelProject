class LineItem < ApplicationRecord
  belongs_to :delivery_order
  belongs_to :merchandise_category
  belongs_to :merchandise
end
