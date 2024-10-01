class Venue < ApplicationRecord
  belongs_to :client
  has_many :order_groups
  acts_as_paranoid
end
