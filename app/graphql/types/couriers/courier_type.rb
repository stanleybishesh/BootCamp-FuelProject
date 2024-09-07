# frozen_string_literal: true

module Types
  module Couriers
    class CourierType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :encrypted_password, String, null: false
      field :reset_password_token, String
      field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
      field :remember_created_at, GraphQL::Types::ISO8601DateTime
      field :first_name, String
      field :last_name, String
      field :bio, String
      field :tenant_id, Integer
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :jti, String, null: true
    end
  end
end
