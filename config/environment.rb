require 'yaml'
require 'rubygems'
gem 'dm-core'
require 'dm-core'
require 'dm-validations'

# Configure data mapper so that it can access the data base
DataMapper.setup(:default,
  YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
)

# Load all the data mapper models into memory
Dir['models/*.rb'].each {|file| require file }
