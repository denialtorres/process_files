require 'csv'
require 'faker'

# Function to generate a fake CPF with the format XXX.XXX.XXX-XX
def generate_cpf
  "#{rand(100..999)}.#{rand(100..999)}.#{rand(100..999)}-#{rand(10..99)}"
end

# Specify the path for the new CSV file
file_path = 'generated_data_set.csv'

# Open a new CSV file and write 100,000 records
CSV.open(file_path, "wb") do |csv|
  # Add headers
  csv << ["name", "cpf"]

  # Generate and write 100,000 records
  100_000.times do
    csv << [Faker::Name.name, generate_cpf]
  end
end

puts "CSV file with 100,000 records generated successfully at #{file_path}"
