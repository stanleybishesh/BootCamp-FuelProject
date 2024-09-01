class Transport < ApplicationRecord
  belongs_to :tenant

  enum status: {
    available: 0,
    in_use: 1,
    maintenance: 2,
    out_of_service: 3
  }
end
