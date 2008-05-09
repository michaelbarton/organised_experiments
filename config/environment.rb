require 'data_mapper'
require 'yaml'
 
# Configure data mapper so that it can access the data base
DataMapper::Database.setup(
  YAML::load(
    File.open(File.dirname(__FILE__) + '/database.yml')
  )
)

# Load all the data mapper models into memory
Dir['models/*.rb'].each {|file| require file }
