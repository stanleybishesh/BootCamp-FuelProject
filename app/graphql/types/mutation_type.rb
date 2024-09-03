# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_transport, mutation: Mutations::Transports::CreateTransport
    field :delete_transport, mutation: Mutations::Transports::DeleteTransport
  end
end
