class Transport < ApplicationRecord
  belongs_to :tenant
  has_many :line_items

  enum status: {
    available: 0,
    in_use: 1,
    maintenance: 2,
    out_of_service: 3
  }

  # enum category: {
  #   Tank_wagon: 0,
  #   Truck: 1,
  #   Tank: 2,
  #   Hydrogen_Tank: 3
  # }

  # enum transport_type: {
  #   Tanker: 0,
  #   Oil_Tanker: 1,
  #   Water_tanker: 3
  # }
end
