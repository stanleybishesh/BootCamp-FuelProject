module Types
  module Transports
    class StatusType < Types::BaseEnum
      value "available", value: "available"
      value "in_use", value: "in_use"
      value "maintenance", value: "maintenance"
      value "out_of_service", value: "out_of_service"
    end
  end
end
