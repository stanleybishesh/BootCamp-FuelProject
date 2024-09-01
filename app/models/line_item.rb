class LineItem < ApplicationRecord
  belongs_to :delivery_order
  belongs_to :merchandise
  belongs_to :transport
end
