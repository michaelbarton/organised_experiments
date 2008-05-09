# This pulls the rake tasks in each of the sub directory rake files into this one
Dir['analysis/*/*.rake'].each {|file| load File.join(File.dirname(__FILE__) ,'/',file) }

load 'config/environment.rb'

# Namespaces allow related tasks to be grouped together
namespace :db do

  desc "Build database tables based on model defined proterties"
  task :create do
    DataMapper::Persistence.auto_migrate!
  end

  desc "Clears all database tables"
  task :drop do
    DataMapper::Persistence.drop_all_tables!
  end
end
