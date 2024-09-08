class Client < ApplicationRecord
  has_many :memberships
  has_many :tenants, through: :memberships
end
