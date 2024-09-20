require "csv"

module Users
  class ImportUsersService
    def self.import_from_csv(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        user_data = row.to_hash

        user = User.find_or_initialize_by(email: user_data["email"])
        user.assign_attributes(
          name: user_data["name"],
          tenant_id: user_data["tenant_id"],
          jti: user_data["jti"],
          password: SecureRandom.hex(8)
        )

        if user.save
          puts "User #{user.email} imported successfully."
        else
          puts "Error importing user #{user.email}: #{user.errors.full_messages.join(', ')}"
        end
      end
    rescue => e
      puts "Error reading CSV file: #{e.message}"
    end
  end
end
