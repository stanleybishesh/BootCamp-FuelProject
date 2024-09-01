# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_signup, mutation: Mutations::Users::UserSignUp
  end
end
