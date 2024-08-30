class Tenant < ApplicationRecord
  has_many :users
  has_many :drivers
  has_many :products
  has_many :assets
  has_many :customers
end
