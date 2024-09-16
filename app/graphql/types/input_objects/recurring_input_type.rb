module Types
  module InputObjects
    class RecurringInputType < Types::BaseInputObject
      argument :frequency, String, required: true
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: true
    end
  end
end
