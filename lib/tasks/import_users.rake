namespace :users do
  desc "Import users from a CSV file"
  task import: :environment do
    file_path = Rails.root.join("users_export.csv")
    puts "Importing users from #{file_path}..."

    begin
      Users::ImportUsersService.import_from_csv(file_path)
      puts "Users imported successfully from #{file_path}."
    rescue => e
      puts "Error importing users: #{e.message}"
    end
  end
end
