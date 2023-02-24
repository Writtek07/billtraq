require 'csv'

# Create a hash with sheet names and their corresponding models
models = {
  "Invoices" => Invoice,
  "Particulars" => Particular,
  "Students" => Student,
  "Users" => User
}

csv_file_path = "#{Rails.root}/lib/data.csv"

# Loop through each model and generate its sheet in the CSV file
CSV.open(csv_file_path, "wb") do |csv|
  models.each do |sheet_name, model|
    # Write the sheet name as the first row in the sheet
    csv << [sheet_name]

    # Write the headers as the second row in the sheet
    csv << model.attribute_names

    # Loop through each record in the model and write its data as a row in the sheet
    model.all.each do |record|
      csv << record.attributes.values
    end

    # Add an empty row to separate the sheets
    csv << []
    #Didnt work when tried all in same sheet just an empty row was added
  end
end
