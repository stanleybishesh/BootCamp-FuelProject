class Mutations::Clients::DeleteClient < Mutations::BaseMutation
  argument :client_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(client_id:)
    begin
      if current_user
        client_service = ::Clients::ClientService.new(client_id: client_id).execute_delete_client
        if client_service.success?
          {
            message: "Client deleted successfully",
            errors: []
          }
        else
          {
            message: "Client failed to delete",
            errors: [ client_service.errors ]
          }
        end
      else
        {
          message: "You are unauthorized to perform this action.",
          errors: [ "User not logged in" ]
        }
      end
    rescue StandardError => err
      {
        message: "Client failed to delete",
        errors: [ err.message ]
      }
    end
  end
end
