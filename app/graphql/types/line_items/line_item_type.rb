# frozen_string_literal: true

module Types
  module LineItems
    class LineItemType < Types::BaseObject
      field :id, ID, null: false
      field :quantity, Integer
      field :delivery_order_id, Integer
      field :merchandise_id, Integer
      field :price, Float
      field :unit, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :merchandise_category_id, Integer
      field :merchandise, Merchandises::MerchandiseType, null: false
      field :merchandise_category, MerchandiseCategories::MerchandiseCategoryType, null: false
    end
  end
end
