class Mutations::Clients::CreateClient < Mutations::BaseMutation
  argument :client_info, Types::InputObjects::ClientInputType, required: true

  field :client, Types::Clients::ClientType, null: false
  field :errors, [ String ], null: true

  def resolve(client_info:)
  end
end
