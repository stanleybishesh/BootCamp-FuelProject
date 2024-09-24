module Mutations
  module Users
    class ImportUsers < BaseMutation
      argument :file, ApolloUploadServer::Upload, required: true

      field :success, Boolean, null: false
      field :errors, [ String ], null: false

      def resolve(file:)
        begin
          ::Users::ImportUsersService.import_from_csv(file)

          { success: true, errors: [] }
        rescue => e
          { success: false, errors: [ e.message ] }
        end
      end
    end
  end
end
