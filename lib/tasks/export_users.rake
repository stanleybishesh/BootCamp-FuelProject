namespace :users do
  desc "Export users to a CSV file"
  task export: :environment do
    file_path = Rails.root.join("users_export.csv")
    puts "Exporting users to #{file_path}..."

    begin
      Users::ExportUsersService.export_to_csv(file_path)
      puts "Users exported successfully to #{file_path}."
    rescue => e
      puts "Error exporting users: #{e.message}"
    end
  end
end
