module Types
  module Merchandises
    class StatusType < Types::BaseEnum
      value "available", "Available status", value: "available"
      value "out_of_stock", "Out Of Stock", value: "out_of_stock"
    end
  end
end
