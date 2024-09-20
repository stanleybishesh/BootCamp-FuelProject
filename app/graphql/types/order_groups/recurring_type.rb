module Types
  module OrderGroups
    class RecurringType < Types::BaseObject
      field :frequency, String, null: false
      field :start_date, GraphQL::Types::ISO8601Date, null: false
      field :end_date, GraphQL::Types::ISO8601Date, null: false
    end
  end
end
