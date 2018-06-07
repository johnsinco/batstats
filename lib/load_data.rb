require 'csv'

DATA_FILES = {
  HitStats: 'Batting-07-12.csv',
  # Players: 'Master-small.csv'
}

DATA_FILES.each do |model, file|
  puts Object.const_get(model).new
end
