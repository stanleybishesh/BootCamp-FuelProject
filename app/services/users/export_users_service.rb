require "csv"

module Users
  class ExportUsersService
    def self.export_to_csv(file_path)
      users = User.all

      CSV.open(file_path, "wb", write_headers: true, headers: [ "id", "email", "name", "tenant_id", "created_at", "updated_at", "jti" ]) do |csv|
        users.each do |user|
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
    end
  end
end
