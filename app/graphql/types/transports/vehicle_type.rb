module Types
  module Transports
    class VehicleType < Types::BaseEnum
      value "Tank", value: "tank"
      value "TankWagon", value: "tank_wagon"
      value "Truck", value: "truck"
      value "SemiTruck", value: "semi_truck"
    end
  end
end
