require 'sqlite3'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :hit_stats, force: true do |t|
    t.integer :year
    t.string :league
    t.string :team
    t.integer :at_bats
    t.integer :games
    t.integer :runs
    t.integer :hits
    t.integer :doubles
    t.integer :triples
    t.integer :home_runs
    t.integer :rbis
    t.integer :stolen_bases
    t.references :player
  end
  create_table :players, force: true, id: false do |t|
    t.string :name
    t.string :id, primary_key: true
  end
end

# Set up model classes
class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
end
