module Types
  module Couriers
    class CourierLoginResponseType < Types::BaseObject
      field :user, Types::Couriers::CourierType, null: true
      field :errors, [ String ], null: false
    end
  end
end
