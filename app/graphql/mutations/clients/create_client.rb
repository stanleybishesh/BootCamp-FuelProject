class Mutations::Clients::CreateClient < Mutations::BaseMutation
  argument :name, String, required: true

  field :client, Types::Clients::ClientType, null: false
  field :message, String, null: true

  def resolve(name:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        client = Client.new(name: name)
        if client.save
          membership = Membership.new(client_id: client.id)
          if membership.save
            {
              message: "Client Registered Successfully",
              client: client
            }
          else
            raise GraphQL::ExecutionError, "Client saved but no membership created"
          end
        else
          raise GraphQL::ExecutionError, "Client could not be registered"
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
