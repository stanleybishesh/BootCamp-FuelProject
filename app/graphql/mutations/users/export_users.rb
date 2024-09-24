module Mutations
  module Users
    class ExportUsers < BaseMutation
      field :url, String, null: true
      field :errors, [ String ], null: false

      def resolve
        begin
          file_path = ::Users::ExportUsersService.export_to_csv

          url = "/#{file_path.relative_path_from(Rails.root.join('public'))}"

          { url: url, errors: [] }
        rescue => e
          { url: nil, errors: [ e.message ] }
        end
      end
    end
  end
end
