class Merchandise < ApplicationRecord
  belongs_to :tenant

  enum status: {
    available: 0,
    out_of_stock: 1
  }
end
