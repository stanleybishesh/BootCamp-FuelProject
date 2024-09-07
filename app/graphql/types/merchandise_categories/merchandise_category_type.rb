# frozen_string_literal: true

module Types
  module MerchandiseCategories
    class MerchandiseCategoryType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :description, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :tenant_id, Integer
    end
  end
end
