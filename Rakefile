# This pulls the rake tasks in each of the sub directory rake files into this one
Dir['analysis/*/*.rake'].each {|file| load File.join(File.dirname(__FILE__) ,'/',file) }

load 'config/environment.rb'

# Namespaces allow related tasks to be grouped together
namespace :db do

  desc "Build database tables based on model defined proterties"
  task :create do
    DataMapper.auto_migrate!
  end

  desc "Clears all database tables"
  task :drop do
    # A horrendous and ugly piece of code. 
    # Why did they get rid of DataMapper::Persistence.drop_all_tables! ?
    repo = repository(:default)
    ObjectSpace.each_object(Class) do |c|
      repo.adapter.destroy_model_storage(repo,c) if c.include? DataMapper::Resource
    end 
  end

end

desc "Rebuilds the project from scratch"
task :rebuild => [
  'db:drop',
  'db:create',
  '001:rebuild'
]
