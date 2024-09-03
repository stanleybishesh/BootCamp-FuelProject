# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_signup, mutation: Mutations::Users::UserSignUp
    field :login, mutation: Mutations::Users::Login
    field :logout, mutation: Mutations::Users::Logout
  end
end
