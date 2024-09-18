module Types
  module Merchandises
    class MerchandiseStatusType < Types::BaseEnum
      value "available", "Available status", value: "available"
      value "out_of_stock", "Out Of Stock", value: "out_of_stock"
    end
  end
end
