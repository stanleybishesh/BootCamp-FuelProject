class Membership < ApplicationRecord
  # belongs_to :tenant
  belongs_to :client

  acts_as_tenant(:tenant)
end
