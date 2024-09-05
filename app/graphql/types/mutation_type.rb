# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_signup, mutation: Mutations::Users::UserSignUp
    field :create_merchandise, mutation: Mutations::Merchandises::CreateMerchandise
    field :delete_merchandise, mutation: Mutations::Merchandises::DeleteMerchandise
    field :update_merchandise, mutation: Mutations::Merchandises::UpdateMerchandise
  end
end
