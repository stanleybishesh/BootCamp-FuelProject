# frozen_string_literal: true

module Types
  module Merchandises
    class MerchandiseType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :status, String
      field :description, String
      field :price, Float
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :merchandise_category_id, ID, null: false
      field :unit, String, null: true
      field :merchandise_category, Types::MerchandiseCategories::MerchandiseCategoryType
    end
  end
end
