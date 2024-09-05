module Types
  module Merchandises
    class StatusType < Types::BaseEnum
      value "active", "Active status", value: "active"
      value "inactive", "Inactive status", value: "inactive"
      value "pending", "Pending status", value: "pending"
    end
  end
end
