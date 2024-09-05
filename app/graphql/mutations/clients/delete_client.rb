class Mutations::Clients::DeleteClient < Mutations::BaseMutation
  argument :client_id, ID, required: true

  field :message, String, null: true

  def resolve(client_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        membership = Membership.find_by(client_id: client_id)
        client = Client.find(membership.client_id)
        if client
          if client.destroy && membership.destroy
            {
              message: "Client Deleted Successfully"
            }
          else
            raise GraphQL::ExecutionError, "Client could not be deleted"
          end
        else
          raise GraphQL::ExecutionError, "Client not found in this tenant"
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
