require 'csv'

DATA_FILES = {
  HitStat: 'data/Batting-07-12.csv',
  # Players: 'Master-small.csv'
}

DATA_FILES.each do |model, file|
  model = Object.const_get(model)
  begin
    CSV.foreach(file, headers: true) do |row|
      puts row.to_h
      model.from_csv_data!(row.to_h)
    end
  rescue CSV::MalformedCSVError => e
    STDERR.puts "ERROR in CSV #{file}"
    STDERR.puts e.backtrace.join("\n")
  end
end
