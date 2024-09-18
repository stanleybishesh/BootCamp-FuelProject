class Venue < ApplicationRecord
  belongs_to :client
  has_many :order_groups, dependent: :destroy
end
