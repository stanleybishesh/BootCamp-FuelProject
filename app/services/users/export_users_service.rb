require "csv"
module Users
  class ExportUsersService
    def self.export_to_csv(file_name = "users_export.csv")
      file_path = Rails.root.join("public", file_name)

      CSV.open(file_path, "wb", write_headers: true, headers: [ "id", "email", "name", "tenant_id", "created_at", "updated_at", "jti" ]) do |csv|
        User.find_each do |user|
          csv << [
            user.id,
            user.email,
            user.name,
            user.tenant_id,
            user.created_at,
            user.updated_at,
            user.jti
          ]
        end
      end

      file_path
    end
  end
end
