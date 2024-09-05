class Tenant < ApplicationRecord
  has_many :merchandises
  has_many :transports
  has_many :users
  has_many :couriers
  has_many :memberships
  has_many :clients, through: :memberships
end
