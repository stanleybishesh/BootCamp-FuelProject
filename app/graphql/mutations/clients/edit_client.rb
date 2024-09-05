class Mutations::Clients::EditClient < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :client_name, String, required: true

  field :client, Types::Clients::ClientType, null: false
  field :message, String, null: true

  def resolve(client_id:, client_name:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        membership = Membership.find_by(client_id: client_id)
        client = Client.find(membership.client_id)
        if client
          updated_client = client.update(name: client_name)
          if updated_client
            {
              message: "Client Updated Successfully",
              client: client
            }
          else
            raise GraphQL::ExecutionError, "Client could not be updated"
          end
        else
          raise GraphQL::ExecutionError, "Client not found"
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
