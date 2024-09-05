# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_signup, mutation: Mutations::Users::UserSignUp
    field :login, mutation: Mutations::Users::Login
    field :logout, mutation: Mutations::Users::Logout
    field :create_client, mutation: Mutations::Clients::CreateClient
    field :edit_client, mutation: Mutations::Clients::EditClient
    field :delete_client, mutation: Mutations::Clients::DeleteClient
    field :create_transport, mutation: Mutations::Transports::CreateTransport
    field :delete_transport, mutation: Mutations::Transports::DeleteTransport
    field :update_transport, mutation: Mutations::Transports::UpdateTransport
  end
end
