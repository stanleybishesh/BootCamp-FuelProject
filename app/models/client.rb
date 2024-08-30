class Client < ApplicationRecord
  has_many :tenants, through: :membership
  has_many :venues
end
